import 'package:flutter/material.dart';
import 'hero_screen_b.dart';

class HeroScreenA extends StatelessWidget {
  const HeroScreenA({super.key});
  static RectTween _createRectTween(Rect? begin, Rect? end) {
    return MaterialRectCenterArcTween(begin: begin, end: end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero — Screen 1')),
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const HeroScreenB()),
          ),
          child: Hero(
            tag: 'profile-image', // must match the tag on Screen B
            createRectTween: _createRectTween,
            child: const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.indigo,
              child: Icon(Icons.person, color: Colors.white, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}