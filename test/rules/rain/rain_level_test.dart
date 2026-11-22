import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/rain/rain_level.dart';

// 要件定義書 7.7「降水量の段階」の表を確かめる。
// 区切りちょうど（0.1・1.0・5.0mm）は上の段階になる。
void main() {
  group('rainLevelOf（降水量の段階）', () {
    test('0.0mm → なし', () {
      expect(rainLevelOf(0.0), RainLevel.none);
    });

    test('0.09mm → なし（0.1mm未満）', () {
      expect(rainLevelOf(0.09), RainLevel.none);
    });

    test('0.1mm → 弱い（区切りちょうどは上の段階）', () {
      expect(rainLevelOf(0.1), RainLevel.light);
    });

    test('0.9mm → 弱い（1mm未満）', () {
      expect(rainLevelOf(0.9), RainLevel.light);
    });

    test('1.0mm → 中くらい（区切りちょうどは上の段階）', () {
      expect(rainLevelOf(1.0), RainLevel.moderate);
    });

    test('4.9mm → 中くらい（5mm未満）', () {
      expect(rainLevelOf(4.9), RainLevel.moderate);
    });

    test('5.0mm → 強い（区切りちょうどは上の段階）', () {
      expect(rainLevelOf(5.0), RainLevel.heavy);
    });
  });
}
