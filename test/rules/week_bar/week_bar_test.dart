import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/week_bar/week_bar.dart';

// 要件定義書 7.9 の「例」の表を1行＝1テストにしている（4件）。
// 表は小数第2位までなので、結果も小数第2位の文字にそろえて比べる
// （7 ÷ 15 = 0.4666… は「0.47」になる）。
String _twoDecimals(double value) => value.toStringAsFixed(2);

void main() {
  group('weekBarOf（週間の気温の幅バー）', () {
    test('週 5〜20°・その日 8〜15° → 始まり 0.20・長さ 0.47', () {
      final bar = weekBarOf(
        weekMinCelsius: 5,
        weekMaxCelsius: 20,
        dayMinCelsius: 8,
        dayMaxCelsius: 15,
      );
      expect(_twoDecimals(bar.start), '0.20');
      expect(_twoDecimals(bar.length), '0.47');
    });

    test('週 5〜20°・その日 5〜20° → 始まり 0.00・長さ 1.00（週いっぱい）', () {
      final bar = weekBarOf(
        weekMinCelsius: 5,
        weekMaxCelsius: 20,
        dayMinCelsius: 5,
        dayMaxCelsius: 20,
      );
      expect(_twoDecimals(bar.start), '0.00');
      expect(_twoDecimals(bar.length), '1.00');
    });

    test('週 5〜20°・その日 12〜12° → 始まり 0.47・長さ 0.00（幅のない日）', () {
      final bar = weekBarOf(
        weekMinCelsius: 5,
        weekMaxCelsius: 20,
        dayMinCelsius: 12,
        dayMaxCelsius: 12,
      );
      expect(_twoDecimals(bar.start), '0.47');
      expect(_twoDecimals(bar.length), '0.00');
    });

    test('週 10〜10°・その日 10〜10° → 始まり 0.00・長さ 1.00（0で割らない）', () {
      final bar = weekBarOf(
        weekMinCelsius: 10,
        weekMaxCelsius: 10,
        dayMinCelsius: 10,
        dayMaxCelsius: 10,
      );
      expect(_twoDecimals(bar.start), '0.00');
      expect(_twoDecimals(bar.length), '1.00');
    });
  });
}
