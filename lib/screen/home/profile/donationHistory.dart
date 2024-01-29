import 'package:flutter/material.dart';

class DonationHistory extends StatelessWidget {
  const DonationHistory({Key? key}) : super(key: key);

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
      body: const Column(),
    );
  }
}
