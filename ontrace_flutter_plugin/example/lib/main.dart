import 'package:flutter/material.dart';
import 'package:ontrace_flutter_plugin/ontrace_flutter_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Example Ontrace SDK"),
        ),
        body: Center(
          child: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const NativePage()));
              },
              child: const Text(
                "Go to native plugin",
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NativePage extends StatelessWidget {
  const NativePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const OntraceFlutterPlugin();
  }
}
