import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        // padding: const EdgeInsets.all(9),
        children: const <Widget>[
          ListTile(
            title: Text('Living'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Electonics'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Books'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('blahblah'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('blahblah'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('blahblah'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('blahblah'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
