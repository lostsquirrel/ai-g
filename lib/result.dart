import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'package:share_plus/share_plus.dart';
import 'config.dart';
import 'prompt.dart';

class Result extends StatelessWidget {
  const Result({super.key});
  static const String routeName = 'result';

  Future<Uint8List> _downloadImage(Prompt args) async {
    Map<String, Object> parmas = {
      "t": [args.t],
      "prompt": [args.prompt]
    };
    var response = await get(Uri.https(serverBase, "", parmas),
        headers: {"Authorization": "Bearer ${args.token}"}); // <--2

    return response.bodyBytes;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Prompt;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: FutureBuilder(
            future: _downloadImage(args),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Image.memory(snapshot.data!),
                    const Spacer(
                      flex: 1,
                    ),
                    IconButton(
                      onPressed: () async {
                        var name = args.prompt.replaceAll(" ", "_");
                        Share.shareXFiles([
                          XFile.fromData(
                            snapshot.data!,
                            name: "$name.png",
                            mimeType: 'image/png',
                          )
                        ]);
                      },
                      icon: const Icon(
                        Icons.share_sharp,
                        size: 36,
                      ),
                    )
                  ],
                );
              } else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return const SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
