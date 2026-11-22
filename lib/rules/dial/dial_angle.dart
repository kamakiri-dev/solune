import 'dart:math' as math;

/// 1時間ぶんの角度（24時間で1周＝360°）。
const double _degreesPerHour = 15;

/// 1分ぶんの角度。
const double _degreesPerMinute = _degreesPerHour / 60;

/// ダイヤル1周の時間数。
const int _hoursPerDay = 24;

/// 1周の角度。
const double _fullTurnDegrees = 360;

/// 半周の角度（ラジアンを度に直すときに使う。π ラジアン＝180°）。
const double _halfTurnDegrees = 180;

/// 時刻（時・分）から、ダイヤルの角度を求める（要件定義書 7.10）。
///
/// 0時を真上の0°とし、時計回りに1時間＝15°、1分＝0.25°。
///
/// 例：6:00 → 90°、15:42 → 235.5°
double dialAngleOf({required int hour, int minute = 0}) {
  return hour * _degreesPerHour + minute * _degreesPerMinute;
}

/// 角度から、針が吸い付く時刻（0〜23時）を求める（要件定義書 7.10）。
///
/// いちばん近い1時間に吸い付く。ちょうど半分（x:30）は先の時刻に吸い付く
/// （Dart の `round()` は、ちょうど半分を切り上げる）。
/// 23:30以降の位置は、同じ日の0時に吸い付く（ダイヤルは円なので、23時の先は0時）。
/// 「24時」を0時に戻すため、24で割った余りにする。
///
/// 例：97°（6:28）→ 6時、97.5°（6:30）→ 7時、352.5°（23:30）→ 0時
int snappedHourOf(double angleDegrees) {
  final nearestHour = (angleDegrees / _degreesPerHour).round();
  return nearestHour % _hoursPerDay;
}

/// 画面に触れた位置から、ダイヤルの角度（0以上360未満）を求める（要件定義書 7.10）。
///
/// [dxFromCenter]・[dyFromCenter] は、ダイヤルの中心から触れた位置までのずれ。
/// 画面と同じく、右と下が正。真上を0°とし、時計回りに数える。
///
/// 中心ちょうどの点は角度が決まらないので、呼ぶ側で「中央のタップ」として扱う。
///
/// 例：真右 → 90°、真下 → 180°、真左 → 270°
double touchAngleOf({
  required double dxFromCenter,
  required double dyFromCenter,
}) {
  // atan2(横のずれ, 上向きのずれ) で、真上から時計回りの角度になる（−180°〜180°）。
  final radians = math.atan2(dxFromCenter, -dyFromCenter);
  final degrees = radians * _halfTurnDegrees / math.pi;
  // 左半分はマイナスになるので、1周足して 0〜360° にそろえる。
  return degrees < 0 ? degrees + _fullTurnDegrees : degrees;
}
