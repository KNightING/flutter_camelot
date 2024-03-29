import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camelot/extension/kotlin_like_extension.dart';
import 'package:flutter_camelot/log/camelot_log.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'architecture.dart';

var _runWithCamelotApp = false;

bool get runWithCamelotApp {
  return _runWithCamelotApp;
}

void camelotRunApp({
  Function()? initAsyncApp,
  required Widget app,
  CamelotConfig? config,
  bool withRiverPodProviderScope = true,
  bool exitOnError = false,
}) {
  // 攔截 Flutter同步異常
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    final error = details.exception;
    final stack = details.stack ?? StackTrace.current;
    CLog.error(error, stackTrace: stack);
    Camelot().config.handleUncaughtError?.call(true, error, stack);
    if (exitOnError) exit(1);
  };

  // 攔截 異步異常 同runZoned但是無法寫到IDE的console
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   CLog.error(error, stackTrace: stack);
  //   config?.handleUncaughtError?.call(false, error, stack);
  //   return true;
  // };
  // return runApp(app);

  camelotZonedGuarded(
    () async {
      await initAsyncApp?.call();
      if (config != null) {
        Camelot().config = config;
      }
      _runWithCamelotApp = true;
      final builder = Builder(builder: (context) {
        Camelot().mediaQuery = MediaQuery.of(context);
        return app;
      });

      if (withRiverPodProviderScope) {
        return runApp(ProviderScope(child: builder));
      } else {
        return runApp(builder);
      }
    },
  );
}

R? camelotZonedGuarded<R>(
  R Function() body,
) {
  return runZoned(
    body,
    zoneSpecification: ZoneSpecification(
      print: (
        Zone self,
        ZoneDelegate parent,
        Zone zone,
        String line,
      ) {
        if (kDebugMode) {
          parent.print(zone, line);
          CLog.debug(line);
        }
      },
      handleUncaughtError: (
        Zone self,
        ZoneDelegate parent,
        Zone zone,
        Object obj,
        StackTrace stack,
      ) {
        // 這裡只會攔截到async function的異常錯誤 / runZonedGuarded的onError相同
        parent.handleUncaughtError(zone, obj, stack);
        CLog.error(obj, stackTrace: stack);
        Camelot().config.handleUncaughtError?.call(false, obj, stack);
      },
    ),
  );
  // return runZonedGuarded(
  //   body,
  //   (Object obj, StackTrace stack) {
  //     CLog.error(obj, stackTrace: stack);
  //     handleUncaughtError?.call(false, obj, stack);
  //   },
  //   zoneSpecification: ZoneSpecification(
  //     print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //       parent.print(zone, line);
  //       CLog.debug(line);
  //     },
  //     handleUncaughtError: (Zone self, ZoneDelegate parent, Zone zone,
  //         Object obj, StackTrace stack) {
  //       parent.handleUncaughtError(zone, obj, stack);
  //       CLog.error(obj, stackTrace: stack);
  //       handleUncaughtError?.call(false, obj, stack);
  //     },
  //   ),
  // );
}
