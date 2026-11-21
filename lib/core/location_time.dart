import 'clock.dart';

/// その地点の現在時刻（要件定義書 7.1）。
///
/// 世界標準時の現在時刻 ＋ [utcOffsetSeconds]（Open-Meteo の `utc_offset_seconds`）。
///
/// 返す値は「その地点の壁掛け時計に出ている時刻」。
/// 端末の時間帯や夏時間の影響を受けないよう、`DateTime` の UTC の形に入れて返す
/// （`isUtc` は true だが、中身は世界標準時ではなく、その地点の時刻）。
/// 予報の時刻も同じ形で持つので、そのまま比べられる。
DateTime locationNow(Clock clock, int utcOffsetSeconds) {
  return clock.nowUtc().add(Duration(seconds: utcOffsetSeconds));
}
