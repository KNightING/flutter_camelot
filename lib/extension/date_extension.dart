import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String f({String format = "yyyy/MM/dd HH:mm:ss"}) {
    return DateFormat(format).format(this);
  }

  String fTime({String separation = ":"}) {
    return f(format: "HH${separation}mm${separation}ss");
  }

  String fDate({String separation = "/"}) {
    return f(format: "yyyy${separation}MM${separation}dd");
  }

  int secondsSinceEpoch() {
    return copyWith(millisecond: 0, microsecond: 0).millisecondsSinceEpoch ~/
        1000;
  }

  DateTime toDate() {
    return copyWith(
        hour: 0, minute: 0, second: 0, millisecond: 0, microsecond: 0);
  }

  DateTime toNewTimeZoneOffset(Duration newTimeZoneOffset) {
    return toUtc().add(newTimeZoneOffset);
  }
}
