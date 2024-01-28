import 'package:flutter/material.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff54408C),
        elevation: 0,
        title: const Text(''),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 48),
            width: double.infinity,
            color: const Color(0xff54408C),
            child: const Column(
              children: [
                Text(
                  'Help Center',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 12),
                Text(
                  'Tell us how we can help 👋',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  'QuickDrop are standing by for service & support!',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 21),
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                children: const <Widget>[
                  SupportCard(
                    title: 'Email',
                    subtitle: 'Send to your email',
                    iconData: Icons.email,
                  ),
                  SupportCard(
                    title: 'Phone Number',
                    subtitle: 'Send to your phone',
                    iconData: Icons.phone,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SupportCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData iconData;

  const SupportCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(iconData, size: 24),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 14, color: Color(0xffA6A6A6)),
            ),
          ],
        ),
      ),
    );
  }
}
