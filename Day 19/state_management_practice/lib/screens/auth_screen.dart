import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_practice/models/auth_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Auth (Provider)')),
      body: Center(
        child: auth.isLoggedIn
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${auth.username}'),
            ElevatedButton(
              onPressed: () => context.read<AuthModel>().logout(),
              child: const Text('Logout'),
            ),
          ],
        )
            : ElevatedButton(
          onPressed: () => context.read<AuthModel>().login('Razi'),
          child: const Text('Login'),
        ),
      ),
    );
  }
}