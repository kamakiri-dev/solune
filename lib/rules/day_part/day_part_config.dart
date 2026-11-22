// 1日の区分の設定（要件定義書 7.2「設定できる値」）。
// どれも「何時」の数字。区間は始まりの時刻を含み、終わりの時刻は含まない。

/// 朝の始まり（時）。これより前（0〜4時）は、どの区分にも入らない。
const int morningStartHour = 5;

/// 昼間の始まり（時）。朝の終わりでもある。
const int daytimeStartHour = 9;

/// 晩の始まり（時）。昼間の終わりでもある。
const int eveningStartHour = 18;

/// 晩の終わり（時）。これ以降（23時）は、どの区分にも入らない。
const int eveningEndHour = 23;
