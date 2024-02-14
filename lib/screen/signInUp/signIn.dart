import 'dart:convert';
//import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import '../../userState.dart';
import '../home/home.dart';
import 'signUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back 👋',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Sign to your account',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    label: 'Email',
                    controller: _emailController,
                  ),
                  _buildTextField(
                    label: 'Password',
                    controller: _passwordController,
                    isPassword: true,
                    icon_suf: Icons.visibility_off_outlined,
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
                  if (_formKey.currentState!.validate()) {
                    // 유효성 검사를 통과 후 HTTP 요청
                    http.Response response = await signIn(
                      _emailController.text,
                      _passwordController.text,
                    );

                    if (response.statusCode == 200) {
                      var data = jsonDecode(response.body);
                      // if (data['token'] != null) {
                      final userId = data['user_id']; // 'id'는 서버 응답에 따라 다를 수 있음
                      UserState.setCurrentUserId(
                          userId); // UserState에 사용자 ID 저장
                      // const storage = FlutterSecureStorage(); // token 로컬저장소에 저장
                      // await storage.write(key: 'token', value: data['token']);

                      //navigate to HomeScreen
                      if (mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                      // }
                    } else {
                      _showErrorDialog(
                          context, "Error code: ${response.statusCode}");
                    }
                  } else {
                    _showErrorDialog(context,
                        "Please check your email or password, and try again");
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: Color(0xff54408C)),
                    ),
                  )
                ],
              ),

              const Divider(),
              const SizedBox(height: 24),
              // 소셜로그인 버튼
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
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
        controller: controller,
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

  Future<http.Response> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://34.71.93.166:8000/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop(); // Dismiss the dialog
            },
          ),
        ],
      ),
    );
  }
}
