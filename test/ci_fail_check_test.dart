import 'package:flutter_test/flutter_test.dart';

// P-03 の確認用：わざと失敗させて、CI が落ちるとマージできないことを確かめる。
// この PR はマージせずに閉じる。
void main() {
  test('わざと失敗するテスト', () {
    expect(1 + 1, 3);
  });
}
