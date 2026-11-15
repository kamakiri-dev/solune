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

    // 画面に実際に使われているテーマが暗いかを確かめる。
    final context = tester.element(find.text('SOLUNE'));
    expect(Theme.of(context).brightness, Brightness.dark);
  });
}
