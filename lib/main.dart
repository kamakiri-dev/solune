import 'package:flutter/material.dart';

void main() {
  runApp(const SoluneApp());
}

/// アプリ全体。いまは「SOLUNE」と出すだけの仮の画面。
class SoluneApp extends StatelessWidget {
  const SoluneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOLUNE',
      // MVP はダークモードだけ（ライトモードはフェーズ2）。
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.dark,
        ),
      ),
      home: const Scaffold(
        body: Center(child: Text('SOLUNE', style: TextStyle(fontSize: 32))),
      ),
    );
  }
}
