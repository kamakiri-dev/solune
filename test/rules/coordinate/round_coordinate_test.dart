import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/coordinate/round_coordinate.dart';

// 要件定義書 7.11 の「例」の表を1行＝1テストにしている（東京駅付近）。
// ちょうど半分の値（35.685 など）は、計算機の誤差でどちらにもなりうるので入れない。
void main() {
  group('roundCoordinate（緯度・経度の丸め）', () {
    test('35.68124 → 35.68（切り捨て側）', () {
      expect(roundCoordinate(35.68124), 35.68);
    });

    test('139.76712 → 139.77（切り上げ側）', () {
      expect(roundCoordinate(139.76712), 139.77);
    });

    test('−0.12574 → −0.13（マイナスでも四捨五入）', () {
      expect(roundCoordinate(-0.12574), -0.13);
    });

    test('35.6 → 35.6（桁が少ないものはそのまま）', () {
      expect(roundCoordinate(35.6), 35.6);
    });
  });
}
