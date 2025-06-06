import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ontrace_flutter_plugin/ontrace_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Example Ontrace SDK')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                text = await OntraceFlutterPlugin.instance.startIdentification(
                  {"apiKey": "YOUR_API_KEY"},
                  onMessage: (result) {
                    log("Flutter side onMessage $result");
                  },
                  onComplete: (result) {
                    log("Flutter side onComplete $result");
                  },
                );
                setState(() {});
              },
              child: const Text("Launch Native Activity"),
            ),
            Text("Response is $text"),
          ],
        ),
      ),
    );
  }
}
