import 'package:flutter_camelot/util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExtension<T> on AsyncValue<T> {
  /// check the value is has data or error and not in refreshing
  ///
  /// [isRefreshing] will set to true and not clear exist value and error when call [WidgetRef.refresh] or [WidgetRef.invalidate]
  ///
  bool get isDone => !isRefreshing && (hasValue || hasError);
}

extension RefExtension on Ref {
  /// wait data when provider read data first time or refreshing.
  /// default timeout is 15 seconds
  ///
  /// did not refresh when value was not done even [needRefresh] is true.
  Future<AsyncValue<T>> waitDataWithTimeout<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    Duration? timeLimit,
    bool needRefresh = false,
  }) {
    final value = read(provider);

    if (needRefresh && value.isDone) {
      if (provider is ProviderOrFamily) {
        invalidate(provider as ProviderOrFamily);
      } else if (provider is Refreshable) {
        refresh(provider as Refreshable);
      }
    }

    return FutureX.checkValueWithTimeout<AsyncValue<T>>(
      timeLimit: timeLimit ?? const Duration(seconds: 15),
      readValue: () => read(provider),
      exitCondition: (value) => value != null && value.isDone,
    );
  }

  /// this method call [waitDataWithTimeout] and [waitDataWithTimeout.needRefresh] is true
  Future<AsyncValue<T>> waitRefreshWithTimeout<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    Duration? timeLimit,
  }) {
    return waitDataWithTimeout(
      provider,
      timeLimit: timeLimit,
      needRefresh: true,
    );
  }
}
