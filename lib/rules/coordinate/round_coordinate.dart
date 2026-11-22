import 'dart:math';

import 'coordinate_config.dart';

/// 10進数の基数（小数の1桁ぶんは10倍）。
const int _decimalBase = 10;

/// 緯度・経度を丸める（要件定義書 7.11）。
///
/// [coordinateDecimalPlaces] 桁（初期値は小数第2位＝約1km）に四捨五入する。
/// API に送る前と、保存する前に使う。
///
/// 例：35.68124 → 35.68、−0.12574 → −0.13
double roundCoordinate(double value) {
  // 100倍して整数に四捨五入し、100で割って戻す（2桁のとき）。
  // Dart の round() はマイナスでも「0から遠いほう」へ丸めるので、−12.574 は −13 になる。
  final scale = pow(_decimalBase, coordinateDecimalPlaces).toDouble();
  return (value * scale).round() / scale;
}
