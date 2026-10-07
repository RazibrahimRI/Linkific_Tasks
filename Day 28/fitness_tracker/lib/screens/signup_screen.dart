import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_email.text.trim().isEmpty || _password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Enter email and password')));
      return;
    }
    final auth = context.read<AuthProvider>();
    final ok = await auth.signUp(_email.text.trim(), _password.text);
    if (!mounted) return;
    if (ok) {
      Navigator.pop(context); // user is logged in, return to the app gate
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(auth.error ?? 'Sign up failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final loading = context.watch<AuthProvider>().loading;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(children: [
            Text('Create Account',
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 24),
            AppTextField(
              controller: _email,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),
            AppTextField(
              controller: _password,
              label: 'Password',
              obscure: true,
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Sign Up',
              loading: loading,
              onPressed: _signUp,
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Have an account? Login'),
            ),
          ]),
        ),
      ),
    );
  }
}