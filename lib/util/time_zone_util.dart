import 'package:flutter_camelot/extension.dart';
import 'datetime_util.dart';

/// 時區轉換，[newTimeZoneOffset]為新時區的差異
class TimeZoneUtil {
  TimeZoneUtil({
    Duration? newTimeZoneOffset,
  }) : newTimeZoneOffset = newTimeZoneOffset ?? DateTime.now().timeZoneOffset;

  final Duration newTimeZoneOffset;

  DateTime now() {
    return DateTime.now().toNewTimeZoneOffset(newTimeZoneOffset);
  }

  DateTime fromSecondsSinceEpoch(
    int secondsSinceEpoch, {
    bool isUtc = false,
  }) {
    return DateTimeUtil.fromSecondsSinceEpoch(
      secondsSinceEpoch,
      isUtc: isUtc,
    ).toNewTimeZoneOffset(newTimeZoneOffset);
  }

  DateTime fromMillisecondsSinceEpoch(
    int millisecondsSinceEpoch, {
    bool isUtc = false,
  }) {
    return DateTime.fromMillisecondsSinceEpoch(
      millisecondsSinceEpoch,
      isUtc: isUtc,
    ).toNewTimeZoneOffset(newTimeZoneOffset);
  }

  DateTime fromMicrosecondsSinceEpoch(
    int microsecondsSinceEpoch, {
    bool isUtc = false,
  }) {
    return DateTime.fromMicrosecondsSinceEpoch(
      microsecondsSinceEpoch,
      isUtc: isUtc,
    ).toNewTimeZoneOffset(newTimeZoneOffset);
  }

  DateTime from(
    DateTime dateTime,
  ) {
    return dateTime.toNewTimeZoneOffset(newTimeZoneOffset);
  }
}
