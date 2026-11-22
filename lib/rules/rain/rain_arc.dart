import 'rain_config.dart';
import 'rain_level.dart';

/// ダイヤルに描く雨の弧の濃さ（要件定義書 7.7）。
enum RainArc {
  /// 描かない
  none,

  /// かすか（いちばん薄い。量はないが、降るかもしれない）
  faint,

  /// 薄い（降水量が「弱い」）
  light,

  /// 中くらい（降水量が「中くらい」）
  moderate,

  /// 濃い（降水量が「強い」）
  heavy,
}

/// 1時間の降水量（mm）と降水確率（%）から、雨の弧を決める（要件定義書 7.7）。
///
/// 1. 降水量が0.1mm以上なら、降水量の段階に合わせる（降水確率は見ない）。
/// 2. 降水量が0.1mm未満で、降水確率が [faintArcProbabilityPercent] 以上なら「かすか」。
/// 3. それ以外は描かない。降水確率が null のときは、基準未満として扱う。
RainArc rainArcOf({
  required double precipitationMm,
  required int? probabilityPercent,
}) {
  switch (rainLevelOf(precipitationMm)) {
    case RainLevel.heavy:
      return RainArc.heavy;
    case RainLevel.moderate:
      return RainArc.moderate;
    case RainLevel.light:
      return RainArc.light;
    case RainLevel.none:
      // 量がないときだけ、降水確率で「かすか」かどうかを決める。
      final probability = probabilityPercent;
      if (probability != null && probability >= faintArcProbabilityPercent) {
        return RainArc.faint;
      }
      return RainArc.none;
  }
}
