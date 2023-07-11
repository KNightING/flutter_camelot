import 'dart:async';

import 'package:flutter_camelot/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 髒資料
class DirtyTagError extends Error {
  @override
  String toString() {
    return "DirtyTag";
  }
}

/// # AutoDisposeAsyncNotifier
///
/// 在[AsyncNotifier]內，觸發多次[build]如:在裡面使用[WidgetRef.watch]觸發
/// 監聽此provider的地方，會等到全部[build]的內容處裡完成，才會接收到data
/// 否則會一直處於loading狀態
/// 如果[init]是一個極度耗時的情況，容易等到天荒地老
///
/// 此mixin則在[build]與[refresh]時，建立[latestTag]並提供給[init]
/// 在[init]經常呼叫檢查[checkTag]來驗證本次是一個髒資料，可以被放棄
/// </br>
///
/// ## 整理
///
/// 應用情境
/// 1. 容易多次觸發[build]
/// 2. [init]是一個耗時的行為
///
/// 使用
/// 1. 在[init]內經常呼叫[checkTag]
mixin AutoDisposeAsyncNotifierTagRefresh<T> on AutoDisposeAsyncNotifier<T> {
  late String _latestTag;

  String get latestTag => _latestTag;

  String _generateLatestTag() {
    _latestTag = generateTag();
    return latestTag;
  }

  String generateTag() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  void checkTag(String tag) {
    if (tag != latestTag) {
      throw DirtyTagError();
    }
  }

  FutureOr<T> init(String tag);

  @override
  FutureOr<T> build() {
    return init(_generateLatestTag());
  }

  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      // can't use `const AsyncValue.loading()` in here because it's type is AsyncValue<Never>.
      // should use `AsyncValue<T>.loading()` or `AsyncLoading<T>()`
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

/// 請參閱[AutoDisposeAsyncNotifierTagRefresh]
mixin AutoDisposeFamilyAsyncNotifierTagRefresh<T, A>
    on AutoDisposeFamilyAsyncNotifier<T, A> {
  late String _latestTag;

  String get latestTag => _latestTag;

  String _generateLatestTag() {
    _latestTag = generateTag();
    return latestTag;
  }

  String generateTag() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  void checkTag(String tag) {
    if (tag != latestTag) {
      throw DirtyTagError();
    }
  }

  FutureOr<T> init(String tag, A arg);

  @override
  FutureOr<T> build(A arg) {
    return init(_generateLatestTag(), arg);
  }

  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      // can't use `const AsyncValue.loading()` in here because it's type is AsyncValue<Never>.
      // should use `AsyncValue<T>.loading()` or `AsyncLoading<T>()`
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

/// 請參閱[AutoDisposeAsyncNotifierTagRefresh]
mixin AsyncNotifierTagRefresh<T> on AsyncNotifier<T> {
  late String _latestTag;

  String get latestTag => _latestTag;

  String _generateLatestTag() {
    _latestTag = generateTag();
    return latestTag;
  }

  String generateTag() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  void checkTag(String tag) {
    if (tag != latestTag) {
      throw DirtyTagError();
    }
  }

  FutureOr<T> init(String tag);

  @override
  FutureOr<T> build() {
    return init(_generateLatestTag());
  }

  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      // can't use `const AsyncValue.loading()` in here because it's type is AsyncValue<Never>.
      // should use `AsyncValue<T>.loading()` or `AsyncLoading<T>()`
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}

/// 請參閱[AutoDisposeAsyncNotifierTagRefresh]
mixin FamilyAsyncNotifierTagRefresh<T, A> on FamilyAsyncNotifier<T, A> {
  late String _latestTag;

  String get latestTag => _latestTag;

  String _generateLatestTag() {
    _latestTag = generateTag();
    return latestTag;
  }

  String generateTag() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }

  void checkTag(String tag) {
    if (tag != latestTag) {
      throw DirtyTagError();
    }
  }

  FutureOr<T> init(String tag, A arg);

  @override
  FutureOr<T> build(A arg) {
    return init(_generateLatestTag(), arg);
  }

  refresh({
    bool setLoading = true,
    bool debounce = true,
  }) {
    if (debounce && !state.isDone) return;
    if (setLoading) {
      // can't use `const AsyncValue.loading()` in here because it's type is AsyncValue<Never>.
      // should use `AsyncValue<T>.loading()` or `AsyncLoading<T>()`
      state = AsyncValue<T>.loading();
    }
    ref.invalidateSelf();
  }
}
