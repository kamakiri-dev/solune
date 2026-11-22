import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/sky/sky_band.dart';

// 要件定義書 7.8 の「例」の表を1行＝1テストにしている（8件）。
// 日の出 6:00・日の入り 17:00・幅30分の日（架空の 1月10日）。
// 表の進み具合は小数第1位までなので、結果も小数第1位の文字にそろえて比べる。
// 表で「—」の行（夜・昼）は、進み具合が null であることを確かめる。

final _sunrise = DateTime.utc(2026, 1, 10, 6, 0);
final _sunset = DateTime.utc(2026, 1, 10, 17, 0);

SkyBand _bandAt(int hour, int minute) => skyBandOf(
  time: DateTime.utc(2026, 1, 10, hour, minute),
  sunrise: _sunrise,
  sunset: _sunset,
);

String? _oneDecimal(double? value) => value?.toStringAsFixed(1);

void main() {
  group('skyBandOf（空の時間帯と進み具合）', () {
    test('5:29 → 夜（明け方の始まりの1分前）', () {
      final band = _bandAt(5, 29);
      expect(band.phase, SkyPhase.night);
      expect(_oneDecimal(band.progress), isNull);
    });

    test('5:30 → 明け方・0.0（始まりの時刻は含む）', () {
      final band = _bandAt(5, 30);
      expect(band.phase, SkyPhase.dawn);
      expect(_oneDecimal(band.progress), '0.0');
    });

    test('6:00 → 明け方・0.5（日の出ちょうどは真ん中）', () {
      final band = _bandAt(6, 0);
      expect(band.phase, SkyPhase.dawn);
      expect(_oneDecimal(band.progress), '0.5');
    });

    test('6:30 → 昼（明け方の終わりの時刻は含まない）', () {
      final band = _bandAt(6, 30);
      expect(band.phase, SkyPhase.day);
      expect(_oneDecimal(band.progress), isNull);
    });

    test('16:29 → 昼（夕方の始まりの1分前）', () {
      final band = _bandAt(16, 29);
      expect(band.phase, SkyPhase.day);
      expect(_oneDecimal(band.progress), isNull);
    });

    test('16:30 → 夕方・0.0（始まりの時刻は含む）', () {
      final band = _bandAt(16, 30);
      expect(band.phase, SkyPhase.dusk);
      expect(_oneDecimal(band.progress), '0.0');
    });

    test('17:00 → 夕方・0.5（日の入りちょうどは真ん中）', () {
      final band = _bandAt(17, 0);
      expect(band.phase, SkyPhase.dusk);
      expect(_oneDecimal(band.progress), '0.5');
    });

    test('17:30 → 夜（夕方の終わりの時刻は含まない）', () {
      final band = _bandAt(17, 30);
      expect(band.phase, SkyPhase.night);
      expect(_oneDecimal(band.progress), isNull);
    });
  });
}
