import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../userState.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Account',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xffE7E1F8),
            backgroundImage: AssetImage('assets/images/user_default.png'),
            radius: 48,
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('Change Picture'),
            ),
          ),
          const SizedBox(height: 27),
          _buildTextField(
            label: 'Name',
            initialValue: ' ',
            controller: nameController,
          ),
          _buildTextField(
            label: 'Email',
            initialValue: ' ',
            controller: emailController,
          ),
          _buildTextField(
            label: 'Phone Number',
            initialValue: ' ',
            controller: phoneNumberController,
            icon: Icons.phone_outlined,
          ),
          _buildTextField(
            label: 'Password',
            initialValue: ' ',
            controller: passwordController,
            isPassword: true,
            icon_suf: Icons.visibility_off_outlined,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () async {
              await saveUserChanges();
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
    required TextEditingController controller,
    bool isPassword = false,
    IconData? icon,
    IconData? icon_suf,
  }) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8.0),
        child: Text(label,
            style: const TextStyle(
                color: Color(0xff121212), fontWeight: FontWeight.normal)),
      ),
      TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: Colors.grey[100],
          prefixIcon:
              icon != null ? Icon(icon, color: const Color(0xff54408C)) : null,
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

  Future<void> fetchUserData() async {
    var userId = UserState.getCurrentUserId();
    final response = await http
        .get(Uri.parse('http://34.134.162.255:8000/user/$userId/profile'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        // Update controllers with the fetched data
        nameController.text = data['name'];
        emailController.text = data['email'];
        phoneNumberController.text = data['phone_number'];
        passwordController.text =
            data['password']; // You might not want to display the password
      });
    }
  }

  Future<void> saveUserChanges() async {
    var userId = UserState.getCurrentUserId();
    final updatedData = {
      'name': nameController.text,
      'email': emailController.text,
      'phone_number': phoneNumberController.text,
      'password': passwordController.text,
    };
    final response = await http.put(
      Uri.parse('http://34.134.162.255:8000/user/$userId/profile'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Success'),
            content: const Text('Your changes just got saved well :)'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the alert dialog
                },
              ),
            ],
          );
        },
      );
    }
  }
}
