// 雨のルールの設定（要件定義書 7.7「設定できる値」）。

/// 「弱い」になる降水量（mm）。これ未満は「なし」。
const double rainLightThresholdMm = 0.1;

/// 「中くらい」になる降水量（mm）。
const double rainModerateThresholdMm = 1.0;

/// 「強い」になる降水量（mm）。
const double rainHeavyThresholdMm = 5.0;

/// 降水量が「なし」でも「かすか」の弧を描く降水確率（%）。これ以上なら描く。
const int faintArcProbabilityPercent = 50;

// ホームの1行目の文（要件定義書 7.7「ホームの1行目」）。

/// 弧が「描かない」ときの文。
const String homeFirstLineNoRain = '雨の心配はなさそうです';

/// 弧が「かすか」のときの文。
const String homeFirstLineFaint = '雨が降るかもしれません';

/// 弧が「薄い」のときの文。
const String homeFirstLineLight = 'ぽつぽつ降りそうです';

/// 弧が「中くらい」のときの文。
const String homeFirstLineModerate = 'しっかり降るので、傘が必要でしょう';

/// 弧が「濃い」のときの文。
const String homeFirstLineHeavy = '強い雨になりそうです';
