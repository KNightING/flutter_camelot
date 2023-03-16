import 'package:flutter/foundation.dart';

import 'camelot_log_event.dart';
import 'camelot_log_level.dart';
import 'camelot_log_provider.dart';

typedef CLog = CamelotLog;

class CamelotLog {
  static void write(CamelotLogLevel level, String message) {
    StackTrace.current;

    final data = CamelotLogData(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      level: level,
      message: message,
      event: CamelotLogEvent.add,
    );

    controller.add(data);
    if (kDebugMode) {
      print(data.toString());
    }
  }

  static void debug(String message) => write(CamelotLogLevel.debug, message);

  static void info(String message) => write(CamelotLogLevel.info, message);

  static void warn(String message) => write(CamelotLogLevel.warn, message);

  static void error(String message) => write(CamelotLogLevel.error, message);

  static void clear() => controller.add(
    CamelotLogData(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      level: CamelotLogLevel.info,
      message: '',
      event: CamelotLogEvent.clear,
    ),
  );
}

class CamelotLogData {
  CamelotLogData({
    required this.event,
    required this.timestamp,
    required this.level,
    required this.message,
  });

  final CamelotLogEvent event;

  final int timestamp;

  final CamelotLogLevel level;

  final String message;

  @override
  String toString() {
    return '${DateTime.fromMillisecondsSinceEpoch(timestamp)}  [ ${level.shortName} ]  $message';
  }
}