import 'dart:math';

import 'day_part.dart';

/// 1時間ごとの値のうち、1日の集計に使うもの（Open-Meteo の hourly の1時間分）。
class HourlyWeather {
  const HourlyWeather({
    required this.time,
    required this.temperatureCelsius,
    required this.apparentTemperatureCelsius,
    required this.windSpeedMetersPerSecond,
  });

  /// その地点の時刻（7.1 の持ち方）。
  final DateTime time;

  /// 気温（°）。
  final double temperatureCelsius;

  /// 体感温度（°）。
  final double apparentTemperatureCelsius;

  /// 風速（m/s）。
  final double windSpeedMetersPerSecond;
}

/// 1日の区分ごとの集計（要件定義書 7.2）。
class DaySummary {
  const DaySummary({
    required this.daytimeAverageTemperature,
    required this.morningEveningAverageTemperature,
    required this.outdoorAverageTemperature,
    required this.outdoorAverageApparentTemperature,
    required this.outdoorMaxWindSpeed,
  });

  /// 昼間の平均気温（°）。
  final double daytimeAverageTemperature;

  /// 朝晩の平均気温（°）。
  final double morningEveningAverageTemperature;

  /// 外にいる時間帯の平均気温（°）。
  final double outdoorAverageTemperature;

  /// 外にいる時間帯の平均の体感温度（°）。
  final double outdoorAverageApparentTemperature;

  /// 外にいる時間帯の、いちばん強い風速（m/s）。
  final double outdoorMaxWindSpeed;
}

/// 1日分の1時間ごとの値から、区分ごとの集計を出す（要件定義書 7.2）。
///
/// [hours] には、その日の0〜23時の値を渡す。区分（[dayPartOf]）に入らない
/// 0〜4時と23時の値は、どの集計にも使わない。
///
/// - 昼間の平均気温：昼間（9〜17時）の気温の平均
/// - 朝晩の平均気温：朝（5〜8時）と晩（18〜22時）の気温（9個）をまとめた平均
/// - 外にいる時間帯（5〜23時。朝・昼間・晩を合わせたもの）：気温の平均・体感温度の平均・いちばん強い風速
///
/// 例：朝10°・昼間18°・晩12° → 昼間の平均 18.0°・朝晩の平均 11.1°
DaySummary daySummaryOf(List<HourlyWeather> hours) {
  final daytime = _hoursIn(hours, {DayPart.daytime});
  final morningEvening = _hoursIn(hours, {DayPart.morning, DayPart.evening});
  final outdoor = _hoursIn(hours, DayPart.values.toSet());

  return DaySummary(
    daytimeAverageTemperature: _average(
      daytime.map((hour) => hour.temperatureCelsius),
    ),
    morningEveningAverageTemperature: _average(
      morningEvening.map((hour) => hour.temperatureCelsius),
    ),
    outdoorAverageTemperature: _average(
      outdoor.map((hour) => hour.temperatureCelsius),
    ),
    outdoorAverageApparentTemperature: _average(
      outdoor.map((hour) => hour.apparentTemperatureCelsius),
    ),
    outdoorMaxWindSpeed: outdoor
        .map((hour) => hour.windSpeedMetersPerSecond)
        .reduce(max),
  );
}

/// [hours] のうち、区分が [parts] のどれかに入るものだけを取り出す。
List<HourlyWeather> _hoursIn(List<HourlyWeather> hours, Set<DayPart> parts) {
  return hours.where((hour) => parts.contains(dayPartOf(hour.time))).toList();
}

/// 値の平均（合計 ÷ 個数）。
double _average(Iterable<double> values) {
  return values.reduce((a, b) => a + b) / values.length;
}
