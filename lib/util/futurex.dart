import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';

class FutureX {
  /// like kotlin withTimeoutOrNull
  /// when timeout then return null
  static Future<T?> withTimeoutOrNull<T>({
    required Duration timeLimit,
    required Future<T?> Function() computation,
  }) async {
    try {
      return await Future(computation).timeout(timeLimit);
    } on TimeoutException {
      return null;
    }
  }

  /// like kotlin withTimeout
  /// Different from [withTimeoutOrNull], which not returns null when the timeout occurs, an [TimeoutException] is thrown instead.
  static Future<T> withTimeout<T>({
    required Duration timeLimit,
    required Future<T> Function() computation,
  }) async {
    return await Future(computation).timeout(
      timeLimit,
    );
  }

  /// while read value via [readValue] and call [exitCondition] to check value
  /// when call [exitCondition] and return true then return the value to [checkValueWithTimeoutOrNull]
  static Future<T?> checkValueWithTimeoutOrNull<T>({
    required Duration timeLimit,
    required FutureOr<T?> Function() readValue,
    required bool Function(T? data) exitCondition,
    Duration? rereadDelayed,
  }) async {
    return await withTimeoutOrNull<T>(
        timeLimit: timeLimit,
        computation: () async {
          T? value;
          while (true) {
            value = await readValue();
            if (exitCondition(value)) return value;
            await Future.delayed(
                rereadDelayed ?? const Duration(milliseconds: 250));
          }
        });
  }

  /// see [checkValueWithTimeoutOrNull]
  /// Different from [checkValueWithTimeoutOrNull], which not returns null when the timeout occurs, an [TimeoutException] is thrown instead.
  static Future<T> checkValueWithTimeout<T>({
    required Duration timeLimit,
    required FutureOr<T?> Function() readValue,
    required bool Function(T? data) exitCondition,
    Duration? rereadDelayed,
  }) async {
    return await withTimeout<T>(
        timeLimit: timeLimit,
        computation: () async {
          T? value;
          while (true) {
            value = await readValue();
            if (value != null && exitCondition(value)) return value;
            await Future.delayed(
                rereadDelayed ?? const Duration(milliseconds: 250));
          }
        });
  }
}
