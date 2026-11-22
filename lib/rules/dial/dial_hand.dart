import '../../core/clock.dart';
import '../../core/location_time.dart';
import 'dial_angle.dart';

/// ダイヤルの針（要件定義書 7.10）。
class DialHand {
  const DialHand({required this.angle, required this.hour});

  /// 針の角度（真上が0°、時計回り）。
  final double angle;

  /// 表示する値の時刻（0〜23時）。この時刻の天気を画面に出す。
  final int hour;
}

/// アプリを開いたとき・ダイヤルの中央をタップしたときの針（要件定義書 7.10）。
///
/// 針はその地点の現在時刻の正確な角度に置く。表示する値は、その時刻の「時」のもの
/// （吸い付きとちがい、分は切り捨てる）。
///
/// 例：現在時刻 15:42 → 針は 235.5°、表示する値は15時のもの
DialHand initialHandOf({required Clock clock, required int utcOffsetSeconds}) {
  final now = locationNow(clock, utcOffsetSeconds);
  return DialHand(
    angle: dialAngleOf(hour: now.hour, minute: now.minute),
    hour: now.hour,
  );
}

/// 指で動かしているあいだ・指を離したときの針（要件定義書 7.10）。
///
/// いちばん近い1時間に吸い付き、針もその時刻の角度に置く。
///
/// 例：97°（6:28）→ 6時（90°）
DialHand snappedHandOf(double angleDegrees) {
  final hour = snappedHourOf(angleDegrees);
  return DialHand(
    angle: dialAngleOf(hour: hour),
    hour: hour,
  );
}
