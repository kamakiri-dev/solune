# SOLUNE

**1日を時計で読む天気アプリ**

数字の一覧ではなく、24時間のダイヤル（円）の形で「いつ・何が起きるか」がひと目でわかる天気アプリです。
雨の時間帯と強さをダイヤルの弧で、空の明るさを外周の色で見せ、その日に合った服装も教えてくれます。

アプリ名の SOLUNE は、SOL（太陽）と LUNE（月）を合わせた造語です。

> いまは開発中です（MVP を作っています）。

## 起動のしかた

[Flutter](https://docs.flutter.dev/get-started/install) を入れてから、リポジトリの直下で次を実行します。

```bash
flutter pub get
```

```bash
flutter run
```

- `flutter pub get`：`pubspec.yaml` に書いたパッケージをダウンロードします。
- `flutter run`：つないでいる端末（Android の実機やエミュレーターなど）でアプリを起動します。

テストは `flutter test` で実行できます。

## ドキュメント

- [要件定義書](docs/requirements.md)
- [タスク一覧](docs/tasks.md)

## 出典

天気データ：[Open-Meteo.com](https://open-meteo.com/)（[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/)）
