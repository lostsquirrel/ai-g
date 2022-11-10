import 'package:aig/config.dart';
import 'package:flutter/material.dart';

import 'generator.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    getToken().then((token) {
      if (token != null) {
        setState(() {
          isLoggedIn = true;
        });
      }
    });

    return isLoggedIn
        ? const Generator()
        : Scaffold(
            appBar: AppBar(
              title: const Text("Login"),
            ),
            body: _build(controller));
  }

  Widget _build(TextEditingController controller) {
    var children = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: TextField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter a Secret',
          ),
          controller: controller,
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: ElevatedButton(
          child: const Text('OK'),
          onPressed: () async {
            await saveToken(controller.text);
          },
        ),
      ),
    ];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
