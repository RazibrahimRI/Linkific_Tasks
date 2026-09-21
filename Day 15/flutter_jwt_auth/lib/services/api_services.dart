import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class ApiService {
  static const String baseUrl = "https://dummyjson.com";
  final _storage = const FlutterSecureStorage();

  Map<String, String> _headers(String? token) {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    if (token != null) headers["Authorization"] = "Bearer $token";
    return headers;
  }

  // Unauthenticated calls (login, register)
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: _headers(null),
        body: jsonEncode(body),
      );
      return _handleResponse(response);
    } catch (e) {
      throw ApiException("Network error: ${e.toString()}");
    }
  }

  // Authenticated calls — this is the interceptor: attaches token, retries once on 401
  Future<Map<String, dynamic>> authenticatedGet(String endpoint) async {
    return _sendWithAuth(() async {
      final token = await _storage.read(key: "access_token");
      return http.get(Uri.parse("$baseUrl$endpoint"), headers: _headers(token));
    });
  }

  Future<Map<String, dynamic>> authenticatedPost(String endpoint, Map<String, dynamic> body) async {
    return _sendWithAuth(() async {
      final token = await _storage.read(key: "access_token");
      return http.post(Uri.parse("$baseUrl$endpoint"), headers: _headers(token), body: jsonEncode(body));
    });
  }

  Future<Map<String, dynamic>> _sendWithAuth(Future<http.Response> Function() request) async {
    var response = await request();

    if (response.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        response = await request(); // retry once with new access token
      }
    }
    return _handleResponse(response);
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await _storage.read(key: "refresh_token");
    if (refreshToken == null) return false;

    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/refresh"),
        headers: _headers(null),
        body: jsonEncode({"refreshToken": refreshToken}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _storage.write(key: "access_token", value: data["accessToken"]);
        return true;
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    final decoded = response.body.isNotEmpty ? jsonDecode(response.body) : {};
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded is Map<String, dynamic> ? decoded : {"data": decoded};
    } else {
      throw ApiException(decoded["message"] ?? "Something went wrong", response.statusCode);
    }
  }
}