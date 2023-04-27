import 'package:flutter_camelot/extension/date_extension.dart';

class DateTimeUtils {
  DateTimeUtils({
    Duration? newTimeZoneOffset,
  }) : newTimeZoneOffset = newTimeZoneOffset ?? DateTime.now().timeZoneOffset;

  final Duration newTimeZoneOffset;

  static DateTime fromSecondsSinceEpoch(int secondsSinceEpoch,
      {bool isUtc = false}) {
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000,
        isUtc: isUtc);
  }

  /// 會回傳為新時區的時間
  DateTime now() {
    return DateTime.now().toNewTimeZoneOffset(newTimeZoneOffset);
  }
}
