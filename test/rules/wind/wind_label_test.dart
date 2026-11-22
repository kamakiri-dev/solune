import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/wind/wind_label.dart';

// 要件定義書 7.5 には例の表がないので、docs/tasks.md の R-05 の完了条件にある
// 3つの例を、1つ＝1テストにしている。
void main() {
  group('windLabelOf（風速の表示）', () {
    test('5.4m/s → 「風 5m/s」（小数は切り捨てになる側）', () {
      expect(windLabelOf(5.4), '風 5m/s');
    });

    test('5.5m/s → 「風 6m/s」（ちょうど半分は切り上げ）', () {
      expect(windLabelOf(5.5), '風 6m/s');
    });

    test('0.2m/s → 「風 0m/s」（ほとんど風がないとき）', () {
      expect(windLabelOf(0.2), '風 0m/s');
    });
  });
}
