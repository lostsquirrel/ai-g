import 'package:flutter/material.dart';

class Donate extends StatelessWidget {
  static const String routeName = '/donate';
  const Donate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Donate")),
      body: Center(child: Image.asset("images/ali.jpg")),
    );
  }
}
