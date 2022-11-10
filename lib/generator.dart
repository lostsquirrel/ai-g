import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'config.dart';
import 'login.dart';

class Generator extends StatefulWidget {
  static const routeName = '/generator';
  const Generator({super.key});

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  bool isLoggedIn = false;
  String imageUrl = "";
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

    return isLoggedIn ? _build(controller, _token) : const Login();
  }

  void setImageUrl(String prompt) {
    if (prompt.isEmpty) return;
    var url = "$serverBase?prompt=$prompt";
    setState(() {
      imageUrl = url;
    });
  }

  _build(TextEditingController controller, String token) {
    var children = <Widget>[];
    if (imageUrl.isNotEmpty) {
      var image = Image.network(
        imageUrl,
        headers: {"Authorization": "Bearer $token"},
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return CircularProgressIndicator(
            color: Colors.orangeAccent,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!.toInt()
                : null,
          );
        },
      );
      children.add(Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: image,
        ),
      ));
    } else {
      children.add(const Expanded(child: Icon(Icons.image)));
    }
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
        onPressed: () async {
          setImageUrl(controller.text);
        },
      ),
    );
    children.add(btn);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generator"),
      ),
      body: Center(
        child: Column(children: children),
      ),
    );
  }
}
