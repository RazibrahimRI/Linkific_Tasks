class Photo {
  const Photo({required this.id, required this.author});

  final String id;
  final String author;

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id']?.toString() ?? '',
      author: json['author'] as String? ?? 'Unknown',
    );
  }

  String get imageUrl => 'https://picsum.photos/id/$id/300/300';
}