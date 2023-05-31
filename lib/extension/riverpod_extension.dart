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
  /// [needRefresh] is `true` and [read]'s value isDone then will run [Ref.refresh]
  /// [refreshWhenHasError] is `true` and [read]'s value hasError then will run [Ref.refresh]
  /// [throwError] is `true` will rethrow error. On the contrary, will return `null` for [Future].
  Future<T?> readAsync<T>(
    ProviderListenable<AsyncValue<T>> provider,
    Refreshable<Future<T>> refreshable, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) async {
    try {
      final value = read(provider);

      if ((needRefresh && value.isDone) ||
          (refreshWhenHasError && value.hasError)) {
        refresh(refreshable);
      }
      return await read(refreshable);
    } catch (error) {
      if (throwError) {
        rethrow;
      } else {
        return null;
      }
    }
  }

  /// read AsyncValue for [FutureProvider].
  /// watch [readAsync]
  Future<T?> readFuture<T>(
    FutureProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeFutureProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeFuture<T>(
    AutoDisposeFutureProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [StreamProvider].
  /// watch [readAsync]
  Future<T?> readStream<T>(
    StreamProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeStreamProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeStream<T>(
    AutoDisposeStreamProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AsyncNotifierProvider].
  /// watch [readAsync]
  Future<T?> readAsyncNotifier<T>(
    AsyncNotifierProvider<AsyncNotifier<T>, T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeAsyncNotifierProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeAsyncNotifier<T>(
    AutoDisposeAsyncNotifierProvider<AutoDisposeAsyncNotifier<T>, T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AsyncNotifierFamilyProvider].
  /// watch [readAsync]
  Future<T?> readAsyncNotifierFamily<T, Arg>(
    AsyncNotifierFamilyProvider<FamilyAsyncNotifier<T, Arg>, T, Arg> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeFamilyAsyncNotifierProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeFamilyAsyncNotifier<T, Arg>(
    AutoDisposeFamilyAsyncNotifierProvider<
            AutoDisposeFamilyAsyncNotifier<T, Arg>, T, Arg>
        provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// if just want read and await data may use
  /// [readAsync],
  /// [readAsyncNotifier],
  /// [readAsyncNotifierFamily],
  /// [readAutoDisposeAsyncNotifier],
  /// [readAutoDisposeFamilyAsyncNotifier],
  /// [readFuture],
  /// [readAutoDisposeFuture],
  /// [readStream],
  /// [readAutoDisposeStream]
  ///
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

extension WidgetRefExtension on WidgetRef {
  /// [needRefresh] is `true` and [read]'s value isDone then will run [Ref.refresh]
  /// [refreshWhenHasError] is `true` and [read]'s value hasError then will run [Ref.refresh]
  /// [throwError] is `true` will rethrow error. On the contrary, will return `null` for [Future].
  Future<T?> readAsync<T>(
    ProviderListenable<AsyncValue<T>> provider,
    Refreshable<Future<T>> refreshable, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) async {
    try {
      final value = read(provider);

      if ((needRefresh && value.isDone) ||
          (refreshWhenHasError && value.hasError)) {
        refresh(refreshable);
      }
      return await read(refreshable);
    } catch (error) {
      if (throwError) {
        rethrow;
      } else {
        return null;
      }
    }
  }

  /// read AsyncValue for [FutureProvider].
  /// watch [readAsync]
  Future<T?> readFuture<T>(
    FutureProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeFutureProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeFuture<T>(
    AutoDisposeFutureProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [StreamProvider].
  /// watch [readAsync]
  Future<T?> readStream<T>(
    StreamProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeStreamProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeStream<T>(
    AutoDisposeStreamProvider<T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AsyncNotifierProvider].
  /// watch [readAsync]
  Future<T?> readAsyncNotifier<T>(
    AsyncNotifierProvider<AsyncNotifier<T>, T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeAsyncNotifierProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeAsyncNotifier<T>(
    AutoDisposeAsyncNotifierProvider<AutoDisposeAsyncNotifier<T>, T> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AsyncNotifierFamilyProvider].
  /// watch [readAsync]
  Future<T?> readAsyncNotifierFamily<T, Arg>(
    AsyncNotifierFamilyProvider<FamilyAsyncNotifier<T, Arg>, T, Arg> provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// read AsyncValue for [AutoDisposeFamilyAsyncNotifierProvider].
  /// watch [readAsync]
  ///
  /// not sure auto dispose provider is readable.
  Future<T?> readAutoDisposeFamilyAsyncNotifier<T, Arg>(
    AutoDisposeFamilyAsyncNotifierProvider<
            AutoDisposeFamilyAsyncNotifier<T, Arg>, T, Arg>
        provider, {
    bool needRefresh = false,
    bool refreshWhenHasError = true,
    bool throwError = false,
  }) {
    return readAsync(
      provider,
      provider.future,
      needRefresh: needRefresh,
      refreshWhenHasError: refreshWhenHasError,
      throwError: throwError,
    );
  }

  /// if just want read and await data may use
  /// [readAsync],
  /// [readAsyncNotifier],
  /// [readAsyncNotifierFamily],
  /// [readAutoDisposeAsyncNotifier],
  /// [readAutoDisposeFamilyAsyncNotifier],
  /// [readFuture],
  /// [readAutoDisposeFuture],
  /// [readStream],
  /// [readAutoDisposeStream]
  ///
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
