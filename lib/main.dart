import 'package:flutter/material.dart';
import 'package:login_test/login.dart';
import 'package:login_test/main_screen.dart';
import 'package:login_test/product_screen.dart';
import 'package:login_test/providers/auth.dart';
import 'package:login_test/providers/list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => ListData()),
      ],
      child: MaterialApp(
        title: 'Login Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: {
          MainScreen.routeName: (ctx) => const MainScreen(),
          ProductScreen.routeName: (ctx) => const ProductScreen(),
        },
      ),
    );
  }
}
