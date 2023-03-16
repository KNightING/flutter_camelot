
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'camelot_log.dart';
import 'camelot_log_event.dart';

final camelotLogPanelProvider = StateProvider<bool>(
  // We return the default sort type, here name.
      (ref) => false,
);

final controller = StreamController<CamelotLogData>();
var stream = controller.stream;

final camelotLogsProvider = StreamProvider((ref) async* {
  // Connect to an API using sockets, and decode the output
  ref.onDispose(controller.close);

  var allLogs = const <CamelotLogData>[];
  await for (final log in stream) {
    // A new message has been received. Let's add it to the list of all messages.
    switch (log.event) {
      case CamelotLogEvent.add:
        allLogs = [...allLogs, log];
        break;
      case CamelotLogEvent.clear:
        allLogs = [];
        break;
    }
    yield allLogs;
  }
});