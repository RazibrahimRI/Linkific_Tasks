import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:testing_practice/user.dart';
import 'package:testing_practice/user_api.dart';

void main() {
  test('User.fromJson creates a correct User', () {
    final user = User.fromJson({'id': 1, 'name': 'Razi', 'email': 'r@x.com'});
    expect(user.id, 1);
    expect(user.name, 'Razi');
    expect(user.email, 'r@x.com');
  });

  test('fetchUser returns a User when the mock returns 200', () async {
    final client = MockClient((request) async {
      return http.Response('{"id": 1, "name": "Razi", "email": "r@x.com"}', 200);
    });
    final user = await fetchUser(client, 1);
    expect(user.name, 'Razi');
  });

  test('fetchUser throws when the mock returns 404', () {
    final client = MockClient((request) async => http.Response('Not found', 404));
    expect(fetchUser(client, 1), throwsException);
  });
}