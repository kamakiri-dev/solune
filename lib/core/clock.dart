/// 現在時刻（世界標準時）を返すもの。
///
/// アプリの中では `DateTime.now()` を直接呼ばず、これを外から渡す。
/// テストでは [FixedClock] に差し替えて、「今」を決まった時刻にできる。
abstract interface class Clock {
  /// 世界標準時（UTC）の現在時刻。
  DateTime nowUtc();
}

/// 本物の時計。端末の現在時刻を世界標準時で返す。
class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime nowUtc() => DateTime.now().toUtc();
}

/// テスト用の時計。いつ呼んでも、決めておいた時刻を返す。
class FixedClock implements Clock {
  FixedClock(DateTime nowUtc) : _nowUtc = nowUtc.toUtc();

  final DateTime _nowUtc;

  @override
  DateTime nowUtc() => _nowUtc;
}
