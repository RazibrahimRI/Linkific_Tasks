import 'package:flutter/material.dart';

class HeroScreenB extends StatelessWidget {
  const HeroScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hero — Screen 2')),
      body: Center(
        child: Hero(
          tag: 'profile-image', // same tag as Screen A — this is what links the flight
          child: const CircleAvatar(
            radius: 120,
            backgroundColor: Colors.indigo,
            child: Icon(Icons.person, color: Colors.white, size: 120),
          ),
        ),
      ),
    );
  }
}