Future<String> fetchUserData() async {
  await Future.delayed(Duration(seconds: 2));
  return 'User data loaded';
}

void main() async {
  print('Fetching...');
  String data = await fetchUserData();
  print(data);
}