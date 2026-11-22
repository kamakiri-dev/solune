import 'package:flutter_test/flutter_test.dart';
import 'package:solune/core/clock.dart';
import 'package:solune/rules/dial/now_mark.dart';

// 要件定義書 7.10 の「例」の表のうち、「今」の印の行を1テストにしている。
// 地点は東京（utc_offset_seconds = 32400）。世界標準時 6:42 は、東京の 15:42。
// 角度は、表と見比べやすいように小数第1位の文字にそろえて比べる。
const int _tokyoOffsetSeconds = 32400;

String _oneDecimal(double degrees) => degrees.toStringAsFixed(1);

void main() {
  group('nowMarkAngleOf（「今」の印）', () {
    test('時刻 15:42（今の印）→ 235.5°', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 6, 42));

      final angle = nowMarkAngleOf(
        clock: clock,
        utcOffsetSeconds: _tokyoOffsetSeconds,
        day: DialDay.today,
      );

      expect(_oneDecimal(angle!), '235.5');
    });

    // 表のほかに、7.10 の「明日のダイヤルには出さない」を確かめる。
    test('明日のダイヤル → 印を出さない（null）', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 6, 42));

      final angle = nowMarkAngleOf(
        clock: clock,
        utcOffsetSeconds: _tokyoOffsetSeconds,
        day: DialDay.tomorrow,
      );

      expect(angle, isNull);
    });

    // 1分ごとに進む印なので、秒は角度に入れない。
    test('時刻 15:42:30 → 235.5°（秒は入れない）', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 6, 42, 30));

      final angle = nowMarkAngleOf(
        clock: clock,
        utcOffsetSeconds: _tokyoOffsetSeconds,
        day: DialDay.today,
      );

      expect(_oneDecimal(angle!), '235.5');
    });
  });
}
