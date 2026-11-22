import 'rain_arc.dart';
import 'rain_config.dart';

/// 針を合わせた時刻の雨の弧から、ホームの1行目の文を決める（要件定義書 7.7）。
///
/// 1行目は雨のことだけを言う。文は [homeFirstLineNoRain] などで変えられる。
String homeFirstLineOf(RainArc arc) {
  switch (arc) {
    case RainArc.none:
      return homeFirstLineNoRain;
    case RainArc.faint:
      return homeFirstLineFaint;
    case RainArc.light:
      return homeFirstLineLight;
    case RainArc.moderate:
      return homeFirstLineModerate;
    case RainArc.heavy:
      return homeFirstLineHeavy;
  }
}
