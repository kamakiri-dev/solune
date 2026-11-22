import 'rain_config.dart';

/// 1時間の降水量の段階（要件定義書 7.7）。
enum RainLevel {
  /// 0.1mm未満
  none,

  /// 0.1〜1mm未満（ぽつぽつ）
  light,

  /// 1〜5mm未満（しっかり）
  moderate,

  /// 5mm以上
  heavy,
}

/// 1時間の降水量（mm）から段階を決める（要件定義書 7.7）。
///
/// 区切りちょうど（0.1・1.0・5.0mm）は上の段階になる。
/// 区切りの値は [rainLightThresholdMm] などで変えられる。
RainLevel rainLevelOf(double precipitationMm) {
  // 強いほうから順に調べ、最初に当てはまった段階にする。
  if (precipitationMm >= rainHeavyThresholdMm) return RainLevel.heavy;
  if (precipitationMm >= rainModerateThresholdMm) return RainLevel.moderate;
  if (precipitationMm >= rainLightThresholdMm) return RainLevel.light;
  return RainLevel.none;
}
