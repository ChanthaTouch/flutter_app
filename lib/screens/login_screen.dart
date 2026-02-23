import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';                    // ← ADD THIS
import '../providers/app_provider.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController(text: 'punleu@company.com');
  final _passwordController = TextEditingController(text: '123456');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Sale Management System')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              CustomButton(
                label: 'Login',
                color: const Color(0xFF438E46),
                onPressed: () {
                  final provider = Provider.of<AppProvider>(context, listen: false);
                  provider.login(_emailController.text);

                  if (provider.currentUser?.role == UserRole.manager) {
                    Navigator.pushReplacementNamed(context, '/manager');
                  } else {
                    Navigator.pushReplacementNamed(context, '/staff');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}