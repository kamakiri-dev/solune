import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/day_part/day_part.dart';

// 要件定義書 7.2 の「時刻 → 区分」の例の表を1行＝1テストにしている（8件）。
// 日付は架空の1月10日。「なし」は null で表す。
DateTime _at(int hour) => DateTime.utc(2026, 1, 10, hour);

void main() {
  group('dayPartOf（1日の区分）', () {
    test('4:00 → なし（朝の前）', () {
      expect(dayPartOf(_at(4)), isNull);
    });

    test('5:00 → 朝（朝の始まりを含む）', () {
      expect(dayPartOf(_at(5)), DayPart.morning);
    });

    test('8:00 → 朝', () {
      expect(dayPartOf(_at(8)), DayPart.morning);
    });

    test('9:00 → 昼間（朝の終わりは含まない）', () {
      expect(dayPartOf(_at(9)), DayPart.daytime);
    });

    test('17:00 → 昼間', () {
      expect(dayPartOf(_at(17)), DayPart.daytime);
    });

    test('18:00 → 晩（昼間の終わりは含まない）', () {
      expect(dayPartOf(_at(18)), DayPart.evening);
    });

    test('22:00 → 晩', () {
      expect(dayPartOf(_at(22)), DayPart.evening);
    });

    test('23:00 → なし（晩の終わりは含まない）', () {
      expect(dayPartOf(_at(23)), isNull);
    });
  });
}
