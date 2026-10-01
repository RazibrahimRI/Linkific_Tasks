import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/app_constants.dart';
import 'photo.dart';

class PhotoService {
  Future<List<Photo>> fetchPhotos(int page) async {
    // Uri.https can only build https:// links. This enforces HTTPS only.
    final uri = Uri.https(AppConstants.photosHost, AppConstants.photosPath, {
      'page': '$page',
      'limit': '${AppConstants.pageSize}',
    });

    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Server error: ${response.statusCode}');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => Photo.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}