import 'sky_config.dart';

/// 空の時間帯（要件定義書 7.8）。ダイヤルの外周の色を決めるのに使う。
enum SkyPhase {
  /// 日の入り＋幅 〜 日の出−幅
  night,

  /// 日の出−幅 〜 日の出＋幅（紺 → 薄い橙 → 空色）
  dawn,

  /// 日の出＋幅 〜 日の入り−幅
  day,

  /// 日の入り−幅 〜 日の入り＋幅（空色 → 橙 → 紺）
  dusk,
}

/// ある時刻の、空の時間帯と進み具合（要件定義書 7.8）。
class SkyBand {
  const SkyBand({required this.phase, this.progress});

  /// 時間帯。
  final SkyPhase phase;

  /// 明け方・夕方の区間の中の進み具合（0〜1）。夜・昼のときは null。
  final double? progress;
}

/// 時刻と、その日の日の出・日の入りから、空の時間帯と進み具合を決める（要件定義書 7.8）。
///
/// - 明け方：日の出−幅 〜 日の出＋幅、夕方：日の入り−幅 〜 日の入り＋幅
/// - 昼：明け方と夕方のあいだ、夜：それ以外
/// - 区間は始まりの時刻を含み、終わりの時刻は含まない。
/// - 進み具合＝(時刻 − 区間の始まり) ÷ 区間の長さ（幅の2倍）。
///
/// 3つの時刻は、どれも同じ形（その地点の時刻。要件定義書 7.1）で渡す。
/// 幅は [skyTwilightWidth] で変えられる。
///
/// 例：日の出 6:00・幅30分 → 5:30 は明け方・0.0、6:00 は明け方・0.5、6:30 は昼
SkyBand skyBandOf({
  required DateTime time,
  required DateTime sunrise,
  required DateTime sunset,
  Duration width = skyTwilightWidth,
}) {
  final dawnProgress = _progressAround(time, sunrise, width);
  if (dawnProgress != null) {
    return SkyBand(phase: SkyPhase.dawn, progress: dawnProgress);
  }
  final duskProgress = _progressAround(time, sunset, width);
  if (duskProgress != null) {
    return SkyBand(phase: SkyPhase.dusk, progress: duskProgress);
  }
  final isDay = time.isAfter(sunrise) && time.isBefore(sunset);
  return SkyBand(phase: isDay ? SkyPhase.day : SkyPhase.night);
}

/// [center] の前後 [width] ずつの区間に [time] が入っていれば、その中の進み具合（0〜1）を返す。
/// 入っていなければ null。区間は始まりを含み、終わりを含まない。
double? _progressAround(DateTime time, DateTime center, Duration width) {
  final start = center.subtract(width);
  final end = center.add(width);
  if (time.isBefore(start) || !time.isBefore(end)) return null;
  return time.difference(start).inMicroseconds /
      end.difference(start).inMicroseconds;
}
