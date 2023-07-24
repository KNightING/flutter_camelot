import 'package:flutter_camelot/extension/riverpod_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin AutoDisposeAsyncNotifierRefresh<T> on AutoDisposeAsyncNotifier<T> {
  /// [Ref.invalidate] 跟 [Ref.refresh] 不會將狀態改為[AsyncValue.loading]
  /// 當[setLoading]為true時, 會先將狀態改成 [AsyncValue.loading]
  /// 當[avoidRunWhenExecuting]為true時, 避免在刷新資料中, 重複調用
  ///
  refresh({
    bool setLoading = true,
    bool avoidRunWhenExecuting = true,
  }) {
    if (avoidRunWhenExecuting) {
      if (state is AsyncLoading) return;
      if (!state.isDone) return;
    }
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

mixin AutoDisposeFamilyAsyncNotifierRefresh<T, A>
    on AutoDisposeFamilyAsyncNotifier<T, A> {
  /// [Ref.invalidate] 跟 [Ref.refresh] 不會將狀態改為[AsyncValue.loading]
  /// 當[setLoading]為true時, 會先將狀態改成 [AsyncValue.loading]
  /// 當[avoidRunWhenExecuting]為true時, 避免在刷新資料中, 重複調用
  ///
  refresh({
    bool setLoading = true,
    bool avoidRunWhenExecuting = true,
  }) {
    if (avoidRunWhenExecuting) {
      if (state is AsyncLoading) return;
      if (!state.isDone) return;
    }
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

mixin AsyncNotifierRefresh<T> on AsyncNotifier<T> {
  /// [Ref.invalidate] 跟 [Ref.refresh] 不會將狀態改為[AsyncValue.loading]
  /// 當[setLoading]為true時, 會先將狀態改成 [AsyncValue.loading]
  /// 當[avoidRunWhenExecuting]為true時, 避免在刷新資料中, 重複調用
  ///
  refresh({
    bool setLoading = true,
    bool avoidRunWhenExecuting = true,
  }) {
    if (avoidRunWhenExecuting) {
      if (state is AsyncLoading) return;
      if (!state.isDone) return;
    }
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

mixin FamilyAsyncNotifierRefresh<T, A> on FamilyAsyncNotifier<T, A> {
  /// [Ref.invalidate] 跟 [Ref.refresh] 不會將狀態改為[AsyncValue.loading]
  /// 當[setLoading]為true時, 會先將狀態改成 [AsyncValue.loading]
  /// 當[avoidRunWhenExecuting]為true時, 避免在刷新資料中, 重複調用
  ///
  refresh({
    bool setLoading = true,
    bool avoidRunWhenExecuting = true,
  }) {
    if (avoidRunWhenExecuting) {
      if (state is AsyncLoading) return;
      if (!state.isDone) return;
    }
    if (setLoading) {
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}
