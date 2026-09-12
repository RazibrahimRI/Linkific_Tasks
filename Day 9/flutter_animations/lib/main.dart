import 'package:flutter/material.dart';
import 'implicit_animations_screen.dart';
import 'explicit_animations_screen.dart';
import 'hero_screen_a.dart';
import 'animated_login_screen.dart';
import 'loading_animation_screen.dart';
import 'animated_list_screen.dart';

void main() => runApp(const AnimationPracticeApp());

class AnimationPracticeApp extends StatelessWidget {
  const AnimationPracticeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation Practice',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <(String, WidgetBuilder)>[
      ('Implicit Animations', (_) => const ImplicitAnimationsScreen()),
      ('Explicit Animations', (_) => const ExplicitAnimationsScreen()),
      ('Hero Animation', (_) => const HeroScreenA()),
      ('Animated Login', (_) => const AnimatedLoginScreen()),
      ('Loading Animation', (_) => const LoadingAnimationScreen()),
      ('Animated List', (_) => const AnimatedListScreen()),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Animation Practice App')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final (title, builder) = items[i];
          return Card(
            child: ListTile(
              title: Text(title),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              // Page transition: custom fade+slide route, not the default push.
              onTap: () => Navigator.of(context).push(_fadeSlideRoute(builder)),
            ),
          );
        },
      ),
    );
  }
}

PageRouteBuilder _fadeSlideRoute(WidgetBuilder builder) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondary) => builder(context),
    transitionDuration: const Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondary, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, .8),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}