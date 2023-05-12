import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AutoDisposeAsyncNotifierRefresh<T> on AutoDisposeAsyncNotifier<T> {
  FutureOr<T> init();

  @override
  FutureOr<T> build() {
    return init();
  }

  Future<void> refresh({bool setStateToLoading = true}) async {
    if (setStateToLoading) {
      state = AsyncValue<T>.loading();
    }
    state = await AsyncValue.guard<T>(() async {
      return await init();
    });
  }
}

mixin AutoDisposeFamilyAsyncNotifierRefresh<T, A>
    on AutoDisposeFamilyAsyncNotifier<T, A> {
  FutureOr<T> init(A arg);

  @override
  FutureOr<T> build(A arg) {
    return init(arg);
  }

  Future<void> refresh({bool setStateToLoading = true}) async {
    if (setStateToLoading) {
      state = AsyncValue<T>.loading();
    }
    state = await AsyncValue.guard<T>(() async {
      return await init(arg);
    });
  }
}

mixin AsyncNotifierRefresh<T> on AsyncNotifier<T> {
  FutureOr<T> init();

  @override
  FutureOr<T> build() {
    return init();
  }

  Future<void> refresh({bool setStateToLoading = true}) async {
    if (setStateToLoading) {
      state = AsyncValue<T>.loading();
    }
    state = await AsyncValue.guard<T>(() async {
      return await init();
    });
  }
}

mixin FamilyAsyncNotifierRefresh<T, A> on FamilyAsyncNotifier<T, A> {
  FutureOr<T> init(A arg);

  @override
  FutureOr<T> build(A arg) {
    return init(arg);
  }

  Future<void> refresh({bool setStateToLoading = true}) async {
    if (setStateToLoading) {
      state = AsyncValue<T>.loading();
    }
    state = await AsyncValue.guard<T>(() async {
      return await init(arg);
    });
  }
}
