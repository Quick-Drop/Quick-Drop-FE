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
            title: Text('Utensils'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Furniture'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('interior'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Electronics'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Clothes'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Cosmetics'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Book'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Groceries'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('e-ticket(mobile coupon)'),
            trailing: Icon(Icons.chevron_right),
          ),
          ListTile(
            title: Text('Etc'),
            trailing: Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
