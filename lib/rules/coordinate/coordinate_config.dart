// 緯度・経度の丸めの設定（要件定義書 7.11）。

/// 何桁目まで残すか。2 なら小数第2位（約1km）まで残し、その下を四捨五入する。
const int coordinateDecimalPlaces = 2;
