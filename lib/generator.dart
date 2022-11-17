import 'package:aig/prompt.dart';
import 'package:flutter/material.dart';
import 'result.dart';
import 'config.dart';
import 'donate.dart';
import 'login.dart';

class Generator extends StatefulWidget {
  static const routeName = '/generator';
  const Generator({super.key});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  bool isLoggedIn = false;
  String _prompt = "";
  int t = 0;
  String _token = "";
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    if (!isLoggedIn) {
      getToken().then((token) {
        if (token != null) {
          setState(() {
            isLoggedIn = true;
            _token = token;
          });
        }
      });
    }

    return isLoggedIn ? _build(controller) : const Login();
  }

  _build(TextEditingController controller) {
    var children = <Widget>[];
    var quta = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter a Promt',
        ),
        maxLength: 79,
        controller: controller,
      ),
    );
    children.add(quta);
    var btn = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: ElevatedButton(
        child: const Text('OK'),
        onPressed: () {
          // setPrompt(controller.text);
          var prompt = controller.text;
          if (prompt.isNotEmpty) {
            t = DateTime.now().millisecondsSinceEpoch;
            var args = Prompt(t.toString(), prompt, _token);
            Navigator.of(context).pushNamed(
              Result.routeName,
              arguments: args,
            );
          }
          // FocusScopeNode currentFocus = FocusScope.of(context);

          // if (!currentFocus.hasPrimaryFocus) {
          //   currentFocus.unfocus();
          // }
        },
      ),
    );
    children.add(btn);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generator"),
        actions: [
          IconButton(
              icon: const Icon(Icons.attach_money),
              onPressed: () =>
                  Navigator.of(context).pushNamed(Donate.routeName))
        ],
      ),
      body: Center(
        child: Column(children: children),
      ),
    );
  }
}
