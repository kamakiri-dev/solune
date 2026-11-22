import 'wind_config.dart';

/// 風速（m/s）から、ダイヤルの中央に出す文を作る（要件定義書 7.5）。
///
/// 小数は四捨五入する（Dart の `round()` は、ちょうど半分を切り上げる）。
/// 風向きは出さない。
///
/// 例：5.4 → 「風 5m/s」、5.5 → 「風 6m/s」、0.2 → 「風 0m/s」
String windLabelOf(double windSpeedMetersPerSecond) {
  final rounded = windSpeedMetersPerSecond.round();
  return '$windLabelPrefix$rounded$windLabelUnit';
}
