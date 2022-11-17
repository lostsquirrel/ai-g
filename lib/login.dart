import 'package:aig/config.dart';
import 'package:flutter/material.dart';

import 'donate.dart';
import 'generator.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static const routeName = '/';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  String _token = '';

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          actions: [
            IconButton(
                icon: const Icon(Icons.attach_money),
                onPressed: () =>
                    Navigator.of(context).pushNamed(Donate.routeName))
          ],
        ),
        body: _build(controller));
  }

  void checkToken() {
    getToken().then((token) {
      if (token != null) {
        setState(() {
          isLoggedIn = true;
          _token = token;
        });
      }
    });
  }

  Widget _build(TextEditingController controller) {
    var children = <Widget>[];
    controller.text = _token;
    if (isLoggedIn) {
      children = <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            // decoration: const InputDecoration(
            //   // border: OutlineInputBorder(color: Colors.grey),
            //   hintText: '',
            // ),
            controller: controller,
            readOnly: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              ElevatedButton(
                child: const Text('Clear'),
                onPressed: () async {
                  await clearToken();
                  setState(() {
                    isLoggedIn = false;
                    _token = '';
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                child: const Text('Go Play'),
                onPressed: () {
                  Navigator.of(context).pushNamed(Generator.routeName);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ];
    } else {
      children = <Widget>[
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
              checkToken();
            },
          ),
        ),
      ];
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
