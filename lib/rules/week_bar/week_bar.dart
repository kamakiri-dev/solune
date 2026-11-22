/// 週の最高と最低が同じとき（0で割ることになるとき）の、棒の始まり。
const double _flatWeekStart = 0;

/// 週の最高と最低が同じときの、棒の長さ（端から端まで）。
const double _flatWeekLength = 1;

/// 週間の気温の幅バー（要件定義書 7.9）。
///
/// どちらも 0〜1 の割合。画面の幅に掛けるのは描くときに行う。
class WeekBar {
  const WeekBar({required this.start, required this.length});

  /// 棒の始まり（左端からの位置）。
  final double start;

  /// 棒の長さ。
  final double length;
}

/// 週の最低・最高と、その日の最低・最高から、幅バーを決める（要件定義書 7.9）。
///
/// - 週の最低＝7日間の最低気温のうちいちばん低い値
/// - 週の最高＝7日間の最高気温のうちいちばん高い値
/// - 始まり＝(その日の最低 − 週の最低) ÷ (週の最高 − 週の最低)
/// - 長さ＝(その日の最高 − その日の最低) ÷ (週の最高 − 週の最低)
///
/// 週の最高と最低が同じときは0で割ることになるので、始まり 0・長さ 1 にする。
///
/// 例：週 5〜20°・その日 8〜15° → 始まり 0.20・長さ 0.47
WeekBar weekBarOf({
  required double weekMinCelsius,
  required double weekMaxCelsius,
  required double dayMinCelsius,
  required double dayMaxCelsius,
}) {
  final weekSpan = weekMaxCelsius - weekMinCelsius;
  if (weekSpan == 0) {
    return const WeekBar(start: _flatWeekStart, length: _flatWeekLength);
  }
  return WeekBar(
    start: (dayMinCelsius - weekMinCelsius) / weekSpan,
    length: (dayMaxCelsius - dayMinCelsius) / weekSpan,
  );
}
