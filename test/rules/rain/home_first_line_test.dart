import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/rain/home_first_line.dart';
import 'package:solune/rules/rain/rain_arc.dart';

// 要件定義書 7.7「ホームの1行目」の表を1行＝1テストにしている（5件）。
void main() {
  group('homeFirstLineOf（ホームの1行目）', () {
    test('描かない → 「雨の心配はなさそうです」', () {
      expect(homeFirstLineOf(RainArc.none), '雨の心配はなさそうです');
    });

    test('かすか → 「雨が降るかもしれません」', () {
      expect(homeFirstLineOf(RainArc.faint), '雨が降るかもしれません');
    });

    test('薄い → 「ぽつぽつ降りそうです」', () {
      expect(homeFirstLineOf(RainArc.light), 'ぽつぽつ降りそうです');
    });

    test('中くらい → 「しっかり降るので、傘が必要でしょう」', () {
      expect(homeFirstLineOf(RainArc.moderate), 'しっかり降るので、傘が必要でしょう');
    });

    test('濃い → 「強い雨になりそうです」', () {
      expect(homeFirstLineOf(RainArc.heavy), '強い雨になりそうです');
    });
  });
}
