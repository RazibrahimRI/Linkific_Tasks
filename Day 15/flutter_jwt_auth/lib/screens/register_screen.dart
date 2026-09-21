import 'package:flutter/material.dart';
import 'package:flutter_jwt_auth/services/api_services.dart';
import 'package:flutter_jwt_auth/services/auth_services.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() { _isLoading = true; _errorMessage = null; });
    try {
      await _authService.register(_nameController.text.trim(), _emailController.text.trim(), _passwordController.text);
      if (!mounted) return;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    } on ApiException catch (e) {
      setState(() => _errorMessage = e.message);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (v) => (v == null || v.isEmpty) ? "Name required" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (v) => (v == null || !v.contains("@")) ? "Valid email required" : null,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                validator: (v) => (v == null || v.length < 6) ? "Min 6 characters" : null,
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null) Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 8),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(onPressed: _handleRegister, child: const Text("Register")),
            ],
          ),
        ),
      ),
    );
  }
}