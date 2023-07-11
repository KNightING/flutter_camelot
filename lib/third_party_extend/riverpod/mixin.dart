import 'dart:async';

import 'package:flutter_camelot/extension/riverpod_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ref.invalidate 跟 ref.refresh 不會觸發loading
mixin AutoDisposeAsyncNotifierRefresh<T> on AutoDisposeAsyncNotifier<T> {
  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

mixin AutoDisposeFamilyAsyncNotifierRefresh<T, A>
    on AutoDisposeFamilyAsyncNotifier<T, A> {
  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

mixin AsyncNotifierRefresh<T> on AsyncNotifier<T> {
  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

mixin FamilyAsyncNotifierRefresh<T, A> on FamilyAsyncNotifier<T, A> {
  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}