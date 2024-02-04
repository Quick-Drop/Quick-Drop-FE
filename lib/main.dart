import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/product_info_api.dart';
import 'onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ItemListApi(),
      child: MaterialApp(
        theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: const StadiumBorder(),
                minimumSize: const Size(327, 48),
                backgroundColor: const Color(0xff54408C),
                textStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xff54408C),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        home: const OnBoarding(),
      ),
    );
  }
}
