import 'package:flutter/material.dart';
import 'screens/instagram_postcard.dart';
import 'screens/whatsapp_chatUI.dart';
import 'screens/ecommerce_grid.dart';
import 'screens/settings_page.dart';
import 'screens/stack_demo.dart';
import 'screens/flex_demo.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Layout Practice')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Instagram Post Card'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => InstagramPost())),
          ),
          ListTile(
            title: const Text('WhatsApp Chat'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WhatsAppChat())),
          ),
          ListTile(
            title: const Text('ecommerce shop'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EcommerceGrid())),
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsPage())),
          ),
          ListTile(
            title: const Text('Stacks'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => StackDemo())),
          ),
          ListTile(
            title: const Text('Flex'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FlexDemo())),
          ),
        ],
      ),
    );
  }
}