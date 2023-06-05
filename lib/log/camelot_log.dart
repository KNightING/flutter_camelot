import 'package:flutter/foundation.dart';

import '../architecture.dart';
import '../camelot_run_app.dart';
import 'camelot_log_event.dart';
import 'camelot_log_level.dart';
import 'camelot_log_provider.dart';

typedef CLog = CamelotLog;

class CamelotLog {
  static void write(CamelotLogLevel level, Object? object) {
    final data = CamelotLogData(
      timestamp: DateTime.now().millisecondsSinceEpoch,
      level: level,
      object: object,
      event: CamelotLogEvent.add,
    );
    controller.add(data);
  }

  static void debug(Object? object) {
    if (kDebugMode || Camelot().config.printDebugLog) {
      write(CamelotLogLevel.debug, object);
    }
  }

  static void info(Object? object) => write(CamelotLogLevel.info, object);

  static void warn(Object? object) => write(CamelotLogLevel.warn, object);

  static void error(Object? error, {StackTrace? stackTrace}) => write(
      CamelotLogLevel.error,
      '$error${stackTrace == null ? '' : '\n\nWhen the exception was thrown, this was the stack:\n$stackTrace'}');

  static void stackTrace(StackTrace stackTrace) =>
      write(CamelotLogLevel.error, '\n$stackTrace');

  static void stackTraceCurrent() => stackTrace(StackTrace.current);

  static void clear() => controller.add(
        CamelotLogData(
          timestamp: DateTime.now().millisecondsSinceEpoch,
          level: CamelotLogLevel.info,
          object: '',
          event: CamelotLogEvent.clear,
        ),
      );
}

class CamelotLogData {
  CamelotLogData({
    required this.event,
    required this.timestamp,
    required this.level,
    required this.object,
  });

  final CamelotLogEvent event;

  final int timestamp;

  final CamelotLogLevel level;

  final Object? object;

  @override
  String toString() {
    return '${DateTime.fromMillisecondsSinceEpoch(timestamp)}  [${level.shortName}]  $object';
  }
}
