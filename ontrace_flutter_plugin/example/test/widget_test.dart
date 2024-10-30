import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:ontrace_flutter_plugin_example/main.dart';

void main() {
  testWidgets('Verify Plugin starts', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text("Go to native plugin"), findsOneWidget);
  });
}
