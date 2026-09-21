import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_services.dart';

class AuthService {
  final ApiService _api = ApiService();
  final _storage = const FlutterSecureStorage();

  static const _accessKey = "access_token";
  static const _refreshKey = "refresh_token";

  Future<void> register(String name, String username, String password) async {
    final response = await _api.post("/auth/register", {
      "name": name,
      "username": username,
      "password": password,
    });
    await _storeTokens(response["accessToken"], response["refreshToken"]);
  }

  Future<void> login(String username, String password) async {
    final response = await _api.post("/auth/login", {
      "username": username,
      "password": password,
    });
    await _storeTokens(response["accessToken"], response["refreshToken"]);
  }

  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: _accessKey, value: accessToken);
    await _storage.write(key: _refreshKey, value: refreshToken);
  }
  Future<bool> isLoggedIn() async {
    final token = await getAccessToken();
    return token != null;
  }

  Future<void> logout() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessKey);
  Future<String?> getRefreshToken() => _storage.read(key: _refreshKey);
}