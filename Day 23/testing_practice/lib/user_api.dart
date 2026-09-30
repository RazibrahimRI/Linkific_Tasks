import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

Future<User> fetchUser(http.Client client, int id) async {
  final response = await client
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/$id'));
  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  }
  throw Exception('Failed to load user');
}