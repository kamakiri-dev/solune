import 'package:flutter_test/flutter_test.dart';
import 'package:solune/core/clock.dart';
import 'package:solune/rules/dial/dial_hand.dart';

// 要件定義書 7.10 の「例」の表の最後の行（開いたときの針）を1テストにしている。
// 地点は東京（utc_offset_seconds = 32400）。世界標準時 6:42 は、東京の 15:42。
// 角度は、表と見比べやすいように小数第1位の文字にそろえて比べる。
const int _tokyoOffsetSeconds = 32400;

String _oneDecimal(double degrees) => degrees.toStringAsFixed(1);

void main() {
  group('initialHandOf（開いたときの針）', () {
    test('現在時刻 15:42 で開く → 針は 235.5°、表示する値は15時のもの', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 6, 42));

      final hand = initialHandOf(
        clock: clock,
        utcOffsetSeconds: _tokyoOffsetSeconds,
      );

      expect(_oneDecimal(hand.angle), '235.5');
      expect(hand.hour, 15);
    });
  });

  // 表のほかに、吸い付いたときは針もその時刻の角度に動くことを確かめる。
  group('snappedHandOf（指で動かしたときの針）', () {
    test('角度 97°（6:28）→ 6時、針は 90°', () {
      final hand = snappedHandOf(97);

      expect(_oneDecimal(hand.angle), '90.0');
      expect(hand.hour, 6);
    });

    test('角度 352.5°（23:30）→ 0時、針は 0°（360° にしない）', () {
      final hand = snappedHandOf(352.5);

      expect(_oneDecimal(hand.angle), '0.0');
      expect(hand.hour, 0);
    });
  });
}
