import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screen/signInUp/signIn.dart';
import 'services/product_list_api.dart';
import 'onboarding.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemListApi = ref.watch(itemListProvider);
    return MaterialApp(
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
      routes: {
        '/signIn': (context) => const SignIn(),
      },
    );
  }
}
