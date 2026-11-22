import '../../core/clock.dart';
import '../../core/location_time.dart';
import 'dial_angle.dart';

/// ダイヤルに出している日。
enum DialDay { today, tomorrow }

/// 「今」の印の角度（要件定義書 7.10）。
///
/// その地点の現在時刻（7.1）の正確な角度に置く（1分ごとに進むので、秒は入れない）。
/// 明日のダイヤルには出さないので、そのときは null を返す。
///
/// 例：現在時刻 15:42 → 235.5°
double? nowMarkAngleOf({
  required Clock clock,
  required int utcOffsetSeconds,
  required DialDay day,
}) {
  if (day == DialDay.tomorrow) {
    return null;
  }
  final now = locationNow(clock, utcOffsetSeconds);
  return dialAngleOf(hour: now.hour, minute: now.minute);
}
