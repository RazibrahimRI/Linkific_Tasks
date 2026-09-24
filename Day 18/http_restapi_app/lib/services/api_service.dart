import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart';
import '../models/weather_model.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET
  static Future<http.Response> getPosts() async {
    return await http.get(Uri.parse('$baseUrl/posts'));
  }

  static const String weatherApiKey = '33b8bfe743aac0229ac54b8048ab345c'; // paste your key

  static Future<WeatherModel> getWeather(String city) async {
    final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$weatherApiKey&units=metric',
    );
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(jsonDecode(response.body));
      } else if (response.statusCode == 401) {
        throw Exception('Invalid or inactive API key');
      } else {
        throw Exception('Failed to load weather: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error. Check your connection.');
    }
  }

  static Future<List<Post>> getPostsList() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/posts'))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Network error. Check your connection.');
    } on Exception catch (e) {
      if (e.toString().contains('TimeoutException')) {
        throw Exception('Request timed out.');
      }
      rethrow;
    }
  }

  // GET with query parameters
  static Future<http.Response> getPostsByUser(int userId) async {
    final uri = Uri.parse('$baseUrl/posts').replace(
      queryParameters: {'userId': userId.toString()},
    );
    return await http.get(uri);
  }
  static Future<List<dynamic>> getCountries() async {
    final response = await http
        .get(Uri.parse('https://restcountries.com/v3.1/all'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load countries');
    }
  }

  // POST
  static Future<http.Response> createPost(String title, String body) async {
    return await http.post(
      Uri.parse('$baseUrl/posts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title, 'body': body, 'userId': 1}),
    );
  }

  // PUT
  static Future<http.Response> updatePost(int id, String title) async {
    return await http.put(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title}),
    );
  }

  static Future<http.Response> patchPost(int id, String title) async {
    return await http.patch(
      Uri.parse('$baseUrl/posts/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': title}),
    );
  }

  // DELETE
  static Future<http.Response> deletePost(int id) async {
    return await http.delete(Uri.parse('$baseUrl/posts/$id'));
  }
}