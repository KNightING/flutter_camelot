import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AutoDisposeAsyncNotifierRefresh<T> on AutoDisposeAsyncNotifier<T> {
  FutureOr<T> _refresh();

  void refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _refresh();
    });
  }
}

mixin AutoDisposeFamilyAsyncNotifierRefresh<T, A>
on AutoDisposeFamilyAsyncNotifier<T, A> {
  FutureOr<T> _refresh();

  void refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _refresh();
    });
  }
}

mixin AsyncNotifierRefresh<T> on AsyncNotifier<T> {
  FutureOr<T> _refresh();

  void refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _refresh();
    });
  }
}
