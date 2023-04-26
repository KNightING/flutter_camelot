import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AutoDisposeAsyncNotifierRefresh<T> on AutoDisposeAsyncNotifier<T> {
  FutureOr<T> init();

  @override
  FutureOr<T> build() {
    return init();
  }

  void refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
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

  void refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
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

  void refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await init();
    });
  }
}
