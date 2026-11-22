import 'weather_icon_config.dart';

/// 天気マークの種類（要件定義書 7.6）。絵ではなく、どのマークかだけを表す。
enum WeatherIcon {
  /// 晴れ
  clear,

  /// 晴れ時々曇り
  partlyCloudy,

  /// 曇り
  cloudy,

  /// 雨
  rain,

  /// 雪
  snow,

  /// 月（夜の晴れ）
  moon,

  /// 月と雲（夜の晴れ時々曇り）
  moonAndCloud,
}

/// ホームのダイヤルの中央に出すマーク（針の時刻の天気）。
///
/// 日の出 ≦ [time] < 日の入り なら昼、それ以外は夜。
/// 夜は、晴れが月に、晴れ時々曇りが月と雲になる。ほかのマークは昼と同じ。
/// 時刻は、どれもその地点の時刻で渡す。
WeatherIcon dialWeatherIconOf({
  required int weatherCode,
  required DateTime time,
  required DateTime sunrise,
  required DateTime sunset,
}) {
  final dayIcon = _dayIconOf(weatherCode);
  final isDaytime = !time.isBefore(sunrise) && time.isBefore(sunset);
  if (isDaytime) return dayIcon;
  return switch (dayIcon) {
    WeatherIcon.clear => WeatherIcon.moon,
    WeatherIcon.partlyCloudy => WeatherIcon.moonAndCloud,
    _ => dayIcon,
  };
}

/// 週間の各行に出すマーク（その日の天気）。週間は、いつも昼のマークにする。
WeatherIcon weekWeatherIconOf(int weatherCode) => _dayIconOf(weatherCode);

/// weather_code から昼のマークを決める。対応表にない番号は曇りにする。
/// 対応表は weather_icon_config.dart にある。
WeatherIcon _dayIconOf(int weatherCode) {
  bool isIn(List<WeatherCodeRange> ranges) =>
      ranges.any((range) => range.contains(weatherCode));

  if (isIn(clearWeatherCodes)) return WeatherIcon.clear;
  if (isIn(partlyCloudyWeatherCodes)) return WeatherIcon.partlyCloudy;
  if (isIn(rainWeatherCodes)) return WeatherIcon.rain;
  if (isIn(snowWeatherCodes)) return WeatherIcon.snow;
  return WeatherIcon.cloudy;
}
