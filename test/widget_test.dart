import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:solune/main.dart';

void main() {
  testWidgets('仮の画面に「SOLUNE」と表示される', (WidgetTester tester) async {
    await tester.pumpWidget(const SoluneApp());

    expect(find.text('SOLUNE'), findsOneWidget);
  });

  testWidgets('アプリはダークモードで表示される', (WidgetTester tester) async {
    await tester.pumpWidget(const SoluneApp());

    final app = tester.widget<MaterialApp>(find.byType(MaterialApp));
    expect(app.themeMode, ThemeMode.dark);
  });
}
