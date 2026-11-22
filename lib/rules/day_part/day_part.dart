import 'day_part_config.dart';

/// 服装と2行目の判断に使う、1日の区分（要件定義書 7.2）。
enum DayPart {
  /// 朝（5〜9時）
  morning,

  /// 昼間（9〜18時）
  daytime,

  /// 晩（18〜23時）
  evening,
}

/// 時刻から、1日の区分を決める（要件定義書 7.2）。
///
/// 区間は始まりの時刻を含み、終わりの時刻は含まない。
/// 0〜5時と23時は、外に出ることが少ないので、どの区分にも入れない（null を返す）。
/// 時（`hour`）だけで決めるので、8:59 は朝、9:00 は昼間になる。
///
/// 例：4:00 → なし、5:00 → 朝、9:00 → 昼間、18:00 → 晩、23:00 → なし
DayPart? dayPartOf(DateTime time) {
  final hour = time.hour;
  if (hour < morningStartHour) return null;
  if (hour < daytimeStartHour) return DayPart.morning;
  if (hour < eveningStartHour) return DayPart.daytime;
  if (hour < eveningEndHour) return DayPart.evening;
  return null;
}
