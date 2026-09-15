import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';

// A few sample network URLs used for the network/cached-image demos and
// the gallery grid. Swap these for anything you like.
const List<String> _networkImages = [
  'https://picsum.photos/id/1015/400/300',
  'https://picsum.photos/id/1016/400/300',
  'https://picsum.photos/id/1018/400/300',
  'https://picsum.photos/id/1020/400/300',
  'https://picsum.photos/id/1024/400/300',
  'https://picsum.photos/id/1027/400/300',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _profileImage;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked = await _picker.pickImage(source: source);
    if (picked == null) return; // user cancelled
    if (!mounted) return;

    final File? confirmed = await _showPreviewDialog(File(picked.path));
    if (confirmed != null) {
      setState(() => _profileImage = confirmed);
    }
  }

  // Preview-before-upload, as a dialog instead of a separate screen route.
  Future<File?> _showPreviewDialog(File imageFile) {
    return showDialog<File>(
      context: context,
      builder: (context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.file(imageFile, height: 250, fit: BoxFit.contain),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context), // cancel
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, imageFile),
                    child: const Text('Use this photo'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Zoomable viewer, as a full-screen dialog instead of a separate screen route.
  void _openViewer(ImageProvider image) {
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (context) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4,
            child: Image(image: image, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Handling')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileSection(),
          const SizedBox(height: 24),
          const Text('Asset image', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildAssetImageRow(),
          const SizedBox(height: 24),
          const Text('Network image (plain Image.network)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _openViewer(NetworkImage(_networkImages[0])),
            child: Image.network(_networkImages[0], height: 180, fit: BoxFit.cover),
          ),
          const SizedBox(height: 24),
          const Text('Cached network image',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildCachedImageDemo(),
          const SizedBox(height: 24),
          const Text('Gallery grid', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _buildGalleryGrid(),
        ],
      ),
    );
  }

  Widget _buildProfileSection() {
    return Column(
      children: [
        GestureDetector(
          onTap: _profileImage == null
              ? null
              : () => _openViewer(FileImage(_profileImage!)),
          child: ClipOval(
            child: SizedBox(
              width: 100,
              height: 100,
              child: _profileImage != null
              // Literal Image.file widget, per the task's requirement
              // list (not just FileImage handed to a background prop).
                  ? Image.file(_profileImage!, fit: BoxFit.cover)
                  : Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: const Icon(Icons.person, size: 50),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text('Change Picture'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo_library),
              label: const Text('Gallery'),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera_alt),
              label: const Text('Camera'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAssetImageRow() {
    // BoxFit comparison, all 7 values, using the same source image.
    // Drop a file at assets/images/sample.jpg for this to render.
    const path = 'assets/images/sample.jpg';
    final fits = {
      'cover': BoxFit.cover,
      'contain': BoxFit.contain,
      'fill': BoxFit.fill,
      'fitWidth': BoxFit.fitWidth,
      'fitHeight': BoxFit.fitHeight,
      'none': BoxFit.none,
      'scaleDown': BoxFit.scaleDown,
    };
    return SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: fits.entries.map((e) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 80,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Image.asset(path, fit: e.value,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image)),
                ),
                Text(e.key, style: const TextStyle(fontSize: 11)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCachedImageDemo() {
    return CachedNetworkImage(
      imageUrl: _networkImages[1],
      height: 180,
      fit: BoxFit.cover,
      fadeInDuration: const Duration(milliseconds: 300),
      placeholder: (context, url) =>
      const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Widget _buildGalleryGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: _networkImages.length,
      itemBuilder: (context, index) {
        final url = _networkImages[index];
        return GestureDetector(
          onTap: () => _openViewer(CachedNetworkImageProvider(url)),
          child: CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator(strokeWidth: 2)),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        );
      },
    );
  }
}