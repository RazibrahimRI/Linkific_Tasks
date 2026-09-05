import 'package:flutter/material.dart';
import '../widgets/profile_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HOME'),

      ),
      body: const Center(
        child: ProfileCard(
          name: 'SLEEPY',
          bio: 'Flutter Developer',
          email: 'sleepy@yahoo.com',
          imageUrl: 'lib/pngs/4at0us-01.jpeg',
        ),
      ),
    );
  }
}