import 'dart:async';

class FutureX {
  /// like kotlin withTimeoutOrNull
  static Future<T?> withTimeoutOrNull<T>({
    required Duration timeLimit,
    required Future<T?> Function() computation,
  }) async {
    try {
      return await Future.microtask(computation).timeout(timeLimit);
    } on TimeoutException {
      return null;
    }
  }

  /// like kotlin withTimeout
  static Future<T> withTimeout<T>({
    required Duration timeLimit,
    required Future<T> Function() computation,
  }) async {
    return await Future.microtask(computation).timeout(timeLimit);
  }

  static Future<T?> checkValueWithTimeoutOrNull<T>({
    required Duration timeLimit,
    required Future<T?> Function() readValue,
    required bool Function(T? data) exitCondition,
    required Duration? rereadDelayed,
  }) async {
    return await withTimeoutOrNull<T>(
        timeLimit: timeLimit,
        computation: () async {
          T? value;
          while (true) {
            value = await readValue();
            if (exitCondition(value)) return value;
            Future.delayed(rereadDelayed ?? const Duration(milliseconds: 250));
          }
        });
  }

  static Future<T?> checkValueWithTimeout<T>({
    required Duration timeLimit,
    required Future<T?> Function() readValue,
    required bool Function(T? data) exitCondition,
    required Duration? rereadDelayed,
  }) async {
    return await withTimeout<T>(
        timeLimit: timeLimit,
        computation: () async {
          T? value;
          while (true) {
            value = await readValue();
            if (value != null && exitCondition(value)) return value;
            Future.delayed(rereadDelayed ?? const Duration(milliseconds: 250));
          }
        });
  }
}
