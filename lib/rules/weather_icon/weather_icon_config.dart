// 天気マークの設定（要件定義書 7.6）。
// Open-Meteo の weather_code の番号を、どのマークにまとめるかの対応表。
// 曇り（3, 45, 48）と、表にない番号は、どこにも入れない（残りはすべて曇りにする）。

/// weather_code の番号のまとまり（first 以上 last 以下）。
class WeatherCodeRange {
  const WeatherCodeRange(this.first, this.last);

  /// まとまりの最初の番号。
  final int first;

  /// まとまりの最後の番号（この番号も含む）。
  final int last;

  /// [code] がこのまとまりに入っているか。
  bool contains(int code) => first <= code && code <= last;
}

/// 晴れ（夜は月）にする番号：0, 1
const List<WeatherCodeRange> clearWeatherCodes = [WeatherCodeRange(0, 1)];

/// 晴れ時々曇り（夜は月と雲）にする番号：2
const List<WeatherCodeRange> partlyCloudyWeatherCodes = [
  WeatherCodeRange(2, 2),
];

/// 雨にする番号：51〜67, 80〜82, 95〜99
const List<WeatherCodeRange> rainWeatherCodes = [
  WeatherCodeRange(51, 67),
  WeatherCodeRange(80, 82),
  WeatherCodeRange(95, 99),
];

/// 雪にする番号：71〜77, 85, 86
const List<WeatherCodeRange> snowWeatherCodes = [
  WeatherCodeRange(71, 77),
  WeatherCodeRange(85, 86),
];
