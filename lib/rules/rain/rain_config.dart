// 雨のルールの設定（要件定義書 7.7「設定できる値」）。

/// 「弱い」になる降水量（mm）。これ未満は「なし」。
const double rainLightThresholdMm = 0.1;

/// 「中くらい」になる降水量（mm）。
const double rainModerateThresholdMm = 1.0;

/// 「強い」になる降水量（mm）。
const double rainHeavyThresholdMm = 5.0;

/// 降水量が「なし」でも「かすか」の弧を描く降水確率（%）。これ以上なら描く。
const int faintArcProbabilityPercent = 50;
