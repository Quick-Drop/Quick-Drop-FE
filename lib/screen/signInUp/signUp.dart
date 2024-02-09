import 'package:http/http.dart' as http;
import 'dart:convert'; // jsonEncode & jsonDecode하기 위해.

import 'package:flutter/material.dart';
import 'package:quick_drop/screen/signInUp/success.dart';
import '../home/home.dart';
import 'signIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text('Skip'),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false,
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Create your own account!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  label: 'Name',
                  controllerInstance: _nameController,
                ),
                _buildTextField(
                  label: 'Email',
                  controllerInstance: _emailController,
                ),
                _buildTextField(
                  label: 'Password',
                  isPassword: true,
                  icon_suf: Icons.visibility_off_outlined,
                  controllerInstance: _passwordController,
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Color(0xff54408C)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                // Call the API
                http.Response response = await createUser();

                if (response.statusCode == 200) {
                  var data = jsonDecode(response.body);
                  if (data['status'] == 'success') {
                  } else {
                    // Handle error or display a message
                  }
                } else {
                  throw Exception('Failed to register. Try again.');
                }
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Have an account?",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignIn()),
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(color: Color(0xff54408C)),
                  ),
                )
              ],
            ),
            const Divider(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controllerInstance,
    bool isPassword = false,
    IconData? icon_suf,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8.0),
        child: Text(
          label,
          style: const TextStyle(
              color: Color(0xff121212), fontWeight: FontWeight.normal),
        ),
      ),
      TextFormField(
        controller: controllerInstance,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.grey[100],
          suffixIcon:
              icon_suf != null ? Icon(icon_suf, color: Colors.grey[400]) : null,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
        ),
        style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
      ),
    ]);
  }

  Future<http.Response> createUser() async {
    final response = await http.post(
      Uri.parse('http://34.134.162.255:8000/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text
        },
      ),
    );
    return response;
  }
}
