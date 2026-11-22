import 'package:flutter_test/flutter_test.dart';
import 'package:solune/rules/weather_icon/weather_icon.dart';

// 要件定義書 7.6 の「例」の表を1行＝1テストにしている（7件）。
// 日付は架空の 1月10日。日の出 6:00・日の入り 17:00 の日。
// 時刻はその地点の壁掛け時計の時刻として、UTC の形に入れる（lib/core と同じ）。

final _sunrise = DateTime.utc(2026, 1, 10, 6);
final _sunset = DateTime.utc(2026, 1, 10, 17);

/// 1月10日の [hour] 時ちょうど。
DateTime _at(int hour) => DateTime.utc(2026, 1, 10, hour);

WeatherIcon _dialIcon(int weatherCode, int hour) => dialWeatherIconOf(
  weatherCode: weatherCode,
  time: _at(hour),
  sunrise: _sunrise,
  sunset: _sunset,
);

void main() {
  group('dialWeatherIconOf（ダイヤルの中央のマーク）', () {
    test('0・12:00 → 晴れ', () {
      expect(_dialIcon(0, 12), WeatherIcon.clear);
    });

    test('0・22:00 → 月（日の入りのあとは夜）', () {
      expect(_dialIcon(0, 22), WeatherIcon.moon);
    });

    test('2・5:00 → 月と雲（日の出の前は夜）', () {
      expect(_dialIcon(2, 5), WeatherIcon.moonAndCloud);
    });

    test('45・9:00 → 曇り', () {
      expect(_dialIcon(45, 9), WeatherIcon.cloudy);
    });

    test('95・15:00 → 雨', () {
      expect(_dialIcon(95, 15), WeatherIcon.rain);
    });

    test('100（表にない番号）・12:00 → 曇り', () {
      expect(_dialIcon(100, 12), WeatherIcon.cloudy);
    });
  });

  group('weekWeatherIconOf（週間のマーク）', () {
    test('0 → 晴れ（週間はいつも昼のマーク）', () {
      expect(weekWeatherIconOf(0), WeatherIcon.clear);
    });
  });
}
