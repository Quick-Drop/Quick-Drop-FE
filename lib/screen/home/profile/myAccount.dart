import 'package:flutter/material.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({Key? key}) : super(key: key);

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
            radius: 48,
            backgroundImage: NetworkImage('https://example.com/avatar.jpg'),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text('Change Picture'),
            ),
          ),
          const SizedBox(height: 27),
          _buildTextField(label: 'Name', initialValue: 'Daniel'),
          _buildTextField(label: 'Email', initialValue: 'parkD@email.com'),
          _buildTextField(
            label: 'Phone Number',
            initialValue: '(+1) 234 567 890',
            icon: Icons.phone_outlined,
          ),
          _buildTextField(
            label: 'Password',
            initialValue: '12345678',
            isPassword: true,
            icon_suf: Icons.visibility_off_outlined,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String initialValue,
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
        controller: TextEditingController(text: initialValue),
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
}
