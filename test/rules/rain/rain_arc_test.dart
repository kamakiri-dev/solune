import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/rain/rain_arc.dart';

// 要件定義書 7.7「雨の弧」の「例」の表を1行＝1テストにしている（8件）。
void main() {
  group('rainArcOf（雨の弧）', () {
    test('10%・0.1mm → 薄い（確率が低くても、量があれば描く）', () {
      expect(
        rainArcOf(precipitationMm: 0.1, probabilityPercent: 10),
        RainArc.light,
      );
    });

    test('60%・0.9mm → 薄い', () {
      expect(
        rainArcOf(precipitationMm: 0.9, probabilityPercent: 60),
        RainArc.light,
      );
    });

    test('20%・1.0mm → 中くらい', () {
      expect(
        rainArcOf(precipitationMm: 1.0, probabilityPercent: 20),
        RainArc.moderate,
      );
    });

    test('40%・5.0mm → 濃い', () {
      expect(
        rainArcOf(precipitationMm: 5.0, probabilityPercent: 40),
        RainArc.heavy,
      );
    });

    test('49%・0.0mm → 描かない', () {
      expect(
        rainArcOf(precipitationMm: 0.0, probabilityPercent: 49),
        RainArc.none,
      );
    });

    test('50%・0.0mm → かすか（50%ちょうどは描く）', () {
      expect(
        rainArcOf(precipitationMm: 0.0, probabilityPercent: 50),
        RainArc.faint,
      );
    });

    test('null・0.0mm → 描かない（確率が null は基準未満として扱う）', () {
      expect(
        rainArcOf(precipitationMm: 0.0, probabilityPercent: null),
        RainArc.none,
      );
    });

    test('null・2.0mm → 中くらい', () {
      expect(
        rainArcOf(precipitationMm: 2.0, probabilityPercent: null),
        RainArc.moderate,
      );
    });
  });
}
