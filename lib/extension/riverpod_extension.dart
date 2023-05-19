import 'package:flutter_camelot/util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExtension<T> on AsyncValue<T> {
  /// check the value is has data or error and not in refreshing
  ///
  /// [isRefreshing] will set to true and not clear exist value and error when call [WidgetRef.refresh] or [WidgetRef.invalidate]
  ///
  bool get isDone => !isRefreshing && (hasValue || hasError);
}

extension WidgetRefExtension on WidgetRef {
  Future<AsyncValue<T>?> waitRefreshWithTimeout<T>(
    ProviderListenable<AsyncValue<T>> provider, {
    Duration? timeLimit,
  }) {
    final value = read(provider);

    if (value.hasValue || value.hasError) {
      if (provider is ProviderOrFamily) {
        invalidate(provider as ProviderOrFamily);
      } else if (provider is Refreshable) {
        refresh(provider as Refreshable);
      }
    }

    return FutureX.checkValueWithTimeoutOrNull<AsyncValue<T>>(
      timeLimit: timeLimit ?? const Duration(seconds: 10),
      readValue: () => read(provider),
      exitCondition: (value) => value != null && value.isDone,
    );
  }
}
