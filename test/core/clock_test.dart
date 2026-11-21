import 'package:flutter_test/flutter_test.dart';
import 'package:solune/core/clock.dart';

void main() {
  group('SystemClock', () {
    test('世界標準時の現在時刻を返す', () {
      final before = DateTime.now().toUtc();
      final now = const SystemClock().nowUtc();
      final after = DateTime.now().toUtc();

      expect(now.isUtc, isTrue);
      expect(now.isBefore(before), isFalse);
      expect(now.isAfter(after), isFalse);
    });
  });

  group('FixedClock', () {
    test('決めておいた時刻を返す（テストで「今」を差し替える）', () {
      final clock = FixedClock(DateTime.utc(2026, 1, 10, 8, 57));

      expect(clock.nowUtc(), DateTime.utc(2026, 1, 10, 8, 57));
    });
  });
}
