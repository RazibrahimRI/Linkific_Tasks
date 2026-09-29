
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

class NetworkScreen extends StatefulWidget {
  const NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  String _result = 'Nothing yet';

  Future<String> _fetch(String url) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();
      if (response.statusCode != 200) {
        throw HttpException('Server returned ${response.statusCode}');
      }
      return await response.transform(utf8.decoder).join();
    } finally {
      client.close();
    }
  }

  Future<void> _run(String url) async {
    setState(() => _result = 'Loading...');
    try {
      final body = await _fetch(url);
      if (!mounted) return;
      setState(() => _result = 'Success: ${body.length} characters');
    } on HttpException catch (e) {
      debugPrint('HTTP error: $e');
      if (!mounted) return;
      setState(() => _result = 'HTTP error: $e');
    } on SocketException catch (e) {
      debugPrint('No connection or bad host: $e');
      if (!mounted) return;
      setState(() => _result = 'Connection error');
    } catch (e) {
      debugPrint('Unknown error: $e');
      if (!mounted) return;
      setState(() => _result = 'Unknown error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_result),
            ElevatedButton(
              onPressed: () => _run('https://jsonplaceholder.typicode.com/posts/1'),
              child: const Text('Good request (200)'),
            ),
            ElevatedButton(
              onPressed: () => _run('https://jsonplaceholder.typicode.com/does-not-exist'),
              child: const Text('Bad path (404)'),
            ),
            ElevatedButton(
              onPressed: () => _run('https://this-host-does-not-exist-12345.com'),
              child: const Text('Bad host'),
            ),
          ],
        ),
      ),
    );
  }
}