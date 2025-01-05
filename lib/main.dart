import 'package:flutter/material.dart';
import 'package:flutter_ecom_basic_app/pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/app_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const EcomApp(),
    ),
  );
}

class EcomApp extends StatelessWidget {
  const EcomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
        });
  }
}
