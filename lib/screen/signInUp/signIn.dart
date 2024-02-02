import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome Back 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Sign to your account',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Your TextFields for email and password will go here
            // ...
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // TODO: Implement forgot password functionality
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Color(0xff54408C)),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement sign-in functionality
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                // TODO: Navigate to the sign-up screen
              },
              child: const Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Color(0xff54408C)),
              ),
            ),
            const Divider(),
            const SizedBox(height: 16),
            // Social Sign-In Buttons
            // You can use SvgPicture.asset() to load your Google and Apple SVG icons
            // For example:
            // SvgPicture.asset('assets/google_icon.svg'),
            // ...
            // Replace this with actual buttons and their functionality
          ],
        ),
      ),
    );
  }
}
