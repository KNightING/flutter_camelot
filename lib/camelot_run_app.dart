import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_camelot/architecture/camelot_service.dart';
import 'package:flutter_camelot/log/camelot_log.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'architecture/camelot_service_config.dart';

var _runWithCamelotApp = false;

bool get runWithCamelotApp {
  return _runWithCamelotApp;
}

void camelotRunApp({
  Function()? initAsyncApp,
  required Widget app,
  CamelotServiceConfig? config,
}) {
  camelotZonedGuarded(() async {
    await initAsyncApp?.call();
    if (config != null) {
      CamelotService().config = config;
    }
    _runWithCamelotApp = true;
    return runApp(app);
  });
}

R? camelotZonedGuarded<R>(R Function() body) {
  return runZonedGuarded(
    body,
    (Object obj, StackTrace stack) {
      CLog.errorObjAndStackTrace(obj, stack);
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        CLog.debug(line);
      },
      handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
          Object obj, StackTrace stack) {
        CLog.errorObjAndStackTrace(obj, stack);
      },
    ),
  );
}
