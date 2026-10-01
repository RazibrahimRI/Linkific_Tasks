import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../widgets/error_view.dart';
import '../../widgets/loading_view.dart';
import '../data/photo.dart';
import '../data/photo_service.dart';
import 'photo_tile.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({super.key});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  final PhotoService _service = PhotoService();
  final ScrollController _controller = ScrollController();
  final List<Photo> _photos = [];
  int _page = 1;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    _loadMore();
  }

  @override
  void dispose() {
    _controller.dispose(); // Proper disposal
    super.dispose();
  }

  void _onScroll() {
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      _loadMore(); // Lazy loading
    }
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final items = await _service.fetchPhotos(_page);
      if (!mounted) return;
      setState(() {
        _photos.addAll(items);
        _page++;
        if (items.length < AppConstants.pageSize) _hasMore = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = 'Could not load photos. Check your internet.');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_photos.isEmpty && _loading) return const LoadingView();
    if (_photos.isEmpty && _error != null) {
      return ErrorView(message: _error!, onRetry: _loadMore);
    }
    return ListView.builder( // Builds only the rows on screen
      controller: _controller,
      itemCount: _photos.length + 1,
      itemBuilder: (context, index) {
        if (index < _photos.length) {
          return PhotoTile(photo: _photos[index]);
        }
        if (_loading) {
          return const Padding(
            padding: EdgeInsets.all(AppConstants.padding),
            child: LoadingView(),
          );
        }
        if (_error != null) {
          return ErrorView(message: _error!, onRetry: _loadMore);
        }
        return const SizedBox.shrink();
      },
    );
  }
}