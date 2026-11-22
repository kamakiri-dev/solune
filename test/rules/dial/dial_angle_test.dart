import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/dial/dial_angle.dart';

// 要件定義書 7.10 の「例」の表のうち、時刻 → 角度（3件）と、角度 → 吸い付く時刻（4件）を
// 1行＝1テストにしている。「今」の印の行は now_mark_test.dart、
// 開いたときの針の行は dial_hand_test.dart にある。
// 角度は、表と見比べやすいように小数第1位の文字にそろえて比べる（90 → 「90.0」）。
String _oneDecimal(double degrees) => degrees.toStringAsFixed(1);

void main() {
  group('dialAngleOf（時刻 → 角度）', () {
    test('時刻 0:00 → 0°', () {
      expect(_oneDecimal(dialAngleOf(hour: 0, minute: 0)), '0.0');
    });

    test('時刻 6:00 → 90°', () {
      expect(_oneDecimal(dialAngleOf(hour: 6, minute: 0)), '90.0');
    });

    test('時刻 12:00 → 180°', () {
      expect(_oneDecimal(dialAngleOf(hour: 12, minute: 0)), '180.0');
    });
  });

  group('snappedHourOf（角度 → 吸い付く時刻）', () {
    test('角度 97°（6:28）→ 6時に吸い付く', () {
      expect(snappedHourOf(97), 6);
    });

    test('角度 97.5°（6:30）→ 7時に吸い付く（半分は先の時刻）', () {
      expect(snappedHourOf(97.5), 7);
    });

    test('角度 352.5°（23:30）→ 0時に吸い付く', () {
      expect(snappedHourOf(352.5), 0);
    });

    test('角度 345°（23:00）→ 23時', () {
      expect(snappedHourOf(345), 23);
    });

    // 表のほかに、docs/tasks.md の R-06 の完了条件「23:30以降の位置は、同じ日の0時に吸い付く」を
    // 一周の終わりぎりぎりで確かめる。
    test('角度 359.75°（23:59）→ 0時に吸い付く（24時にはならない）', () {
      expect(snappedHourOf(359.75), 0);
    });
  });

  // 表には例がないが、7.10 の「画面に触れた位置から角度を求めるときも、
  // 真上を0°、時計回りに数える」を、上下左右の4つの向きで確かめる。
  group('touchAngleOf（画面に触れた位置 → 角度）', () {
    test('真上 → 0°', () {
      expect(
        _oneDecimal(touchAngleOf(dxFromCenter: 0, dyFromCenter: -100)),
        '0.0',
      );
    });

    test('真右 → 90°', () {
      expect(
        _oneDecimal(touchAngleOf(dxFromCenter: 100, dyFromCenter: 0)),
        '90.0',
      );
    });

    test('真下 → 180°', () {
      expect(
        _oneDecimal(touchAngleOf(dxFromCenter: 0, dyFromCenter: 100)),
        '180.0',
      );
    });

    test('真左 → 270°（マイナスの角度にしない）', () {
      expect(
        _oneDecimal(touchAngleOf(dxFromCenter: -100, dyFromCenter: 0)),
        '270.0',
      );
    });
  });
}
