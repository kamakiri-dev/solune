import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/day_part/day_summary.dart';

// 平均は割り切れないことがあるので、小数第1位の文字にそろえて比べる
// （100 ÷ 9 = 11.11… は「11.1」になる）。
String _oneDecimal(double value) => value.toStringAsFixed(1);

/// 架空の1月10日の0〜23時の、1時間ごとの値を作る。
/// 値は、時（0〜23）を受け取る関数で決める。
List<HourlyWeather> _dayOf({
  required double Function(int hour) temperature,
  double Function(int hour)? apparentTemperature,
  double Function(int hour)? windSpeed,
}) {
  return [
    for (var hour = 0; hour < 24; hour++)
      HourlyWeather(
        time: DateTime.utc(2026, 1, 10, hour),
        temperatureCelsius: temperature(hour),
        apparentTemperatureCelsius:
            apparentTemperature?.call(hour) ?? temperature(hour),
        windSpeedMetersPerSecond: windSpeed?.call(hour) ?? 0,
      ),
  ];
}

/// 朝（5〜8時）10°・昼間（9〜17時）18°・晩（18〜22時）12° の日。
/// 区分の外（0〜4時・23時）は 0° にして、平均に入らないことも確かめる。
double _exampleTemperature(int hour) {
  if (hour >= 5 && hour < 9) return 10;
  if (hour >= 9 && hour < 18) return 18;
  if (hour >= 18 && hour < 23) return 12;
  return 0;
}

void main() {
  group('daySummaryOf（1日の区分ごとの集計）', () {
    // 要件定義書 7.2 の「1時間ごとの気温」の例の表（1件）。
    test('朝10°・昼間18°・晩12° → 昼間の平均 18.0°・朝晩の平均 11.1°', () {
      final summary = daySummaryOf(_dayOf(temperature: _exampleTemperature));

      expect(_oneDecimal(summary.daytimeAverageTemperature), '18.0');
      // (10×4＋12×5)÷9 ＝ 11.11…
      expect(_oneDecimal(summary.morningEveningAverageTemperature), '11.1');
    });

    // 7.2 に例の表がないので、7.3 の補足に使う「外にいる時間帯（5〜23時）」の
    // 集計を、上と同じ日の値で確かめる。
    test('外にいる時間帯（5〜23時）の平均気温・平均の体感温度・いちばん強い風速', () {
      final summary = daySummaryOf(
        _dayOf(
          temperature: _exampleTemperature,
          // 体感温度は、どの区分も気温より3°低くする。区分の外は 0°。
          apparentTemperature: (hour) {
            final temperature = _exampleTemperature(hour);
            return temperature == 0 ? 0 : temperature - 3;
          },
          // 風は13時がいちばん強い（6m/s）。区分の外の0時・23時は
          // もっと強い（15m/s）が、外にいる時間帯ではないので入らない。
          windSpeed: (hour) {
            if (hour == 13) return 6;
            if (hour == 0 || hour == 23) return 15;
            return 2;
          },
        ),
      );

      // (10×4＋18×9＋12×5)÷18 ＝ 14.55…
      expect(_oneDecimal(summary.outdoorAverageTemperature), '14.6');
      // (7×4＋15×9＋9×5)÷18 ＝ 11.55…
      expect(_oneDecimal(summary.outdoorAverageApparentTemperature), '11.6');
      expect(summary.outdoorMaxWindSpeed, 6);
    });
  });
}
