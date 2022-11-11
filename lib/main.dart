import 'package:aig/generator.dart';
import 'package:flutter/material.dart';

import 'donate.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Images',
      initialRoute: Login.routeName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        Login.routeName: (context) => const Login(),
        Generator.routeName: (context) => const Generator(),
        Donate.routeName: (context) => const Donate(),
      },
    );
  }
}
