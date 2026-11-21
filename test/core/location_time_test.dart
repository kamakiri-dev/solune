import 'package:flutter_test/flutter_test.dart';
import 'package:solune/core/clock.dart';
import 'package:solune/core/location_time.dart';

// 要件定義書 7.1 の「例」の表を、1行＝1テストにしている。
void main() {
  group('locationNow（その地点の現在時刻）', () {
    test('1/10 8:57 と 32400（東京）→ 1/10 17:57', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 8, 57));

      expect(locationNow(clock, 32400), DateTime.utc(2026, 1, 10, 17, 57));
    });

    test('1/10 8:57 と 0（ロンドン）→ 1/10 8:57', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 8, 57));

      expect(locationNow(clock, 0), DateTime.utc(2026, 1, 10, 8, 57));
    });

    test('1/10 20:00 と 32400（東京）→ 1/11 5:00（日付も変わる）', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 20, 0));

      expect(locationNow(clock, 32400), DateTime.utc(2026, 1, 11, 5, 0));
    });

    test('1/10 3:00 と −18000（ニューヨーク）→ 1/9 22:00（日付が前に戻る）', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 3, 0));

      expect(locationNow(clock, -18000), DateTime.utc(2026, 1, 9, 22, 0));
    });
  });
}
