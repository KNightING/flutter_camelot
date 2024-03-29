import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String f({String format = "yyyy/MM/dd HH:mm:ss"}) {
    return DateFormat(format).format(this);
  }

  String fTime({String separation = ":"}) {
    return f(format: "HH${separation}mm${separation}ss");
  }

  String fDate({String separation = "/"}) {
    return f(format: "yyyy${separation}MM${separation}dd");
  }

  int get secondsSinceEpoch {
    return copyWith(millisecond: 0, microsecond: 0).millisecondsSinceEpoch ~/
        1000;
  }

  DateTime toDate() {
    return DateUtils.dateOnly(this);
  }

  bool isSameDay(DateTime target) {
    return DateUtils.isSameDay(this, target);
  }

  bool isSameMonth(DateTime target) {
    return DateUtils.isSameMonth(this, target);
  }

  bool isSameYear(DateTime target) {
    return year == target.year;
  }

  /// 移除，因為DateTime本身含有timezone的資訊，除非複寫DateTime，否則無法處理timezone
// DateTime toNewTimeZoneOffset(Duration newTimeZoneOffset) {
//   return toUtc().add(newTimeZoneOffset);
// }
}
