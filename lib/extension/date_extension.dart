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
}
