import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/product_info_api.dart';
import 'screen/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemListApi(),
      child: const MaterialApp(
        home: Scaffold(
          body: HomeScreen(),
        ),
      ),
    );
  }
}
