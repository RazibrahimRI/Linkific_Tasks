import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../data/photo.dart';

class PhotoTile extends StatelessWidget {
  const PhotoTile({super.key, required this.photo});

  final Photo photo;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Photo by ${photo.author}', // Accessibility label
      child: Card(
        child: ListTile(
          leading: CachedNetworkImage( // Image caching
            imageUrl: photo.imageUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
            placeholder: (context, url) => const SizedBox(
              width: 56,
              height: 56,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (context, url, error) =>
            const Icon(Icons.broken_image),
          ),
          title: Text(photo.author),
        ),
      ),
    );
  }
}