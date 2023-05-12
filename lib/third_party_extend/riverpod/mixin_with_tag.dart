import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DirtyTagError extends Error {
  @override
  String toString() {
    return "DirtyTag";
  }
}

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

  Future<void> refresh() async {
    // can't use `const AsyncValue.loading()` in here because it's type is AsyncValue<Never>.
    // should use `AsyncValue<T>.loading()` or `AsyncLoading<T>()`
    state = AsyncValue<T>.loading();
    state = await AsyncValue.guard<T>(() async {
      return await init(_generateLatestTag());
    });
  }
}

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

  Future<void> refresh() async {
    state = AsyncValue<T>.loading();
    state = await AsyncValue.guard<T>(() async {
      return await init(_generateLatestTag(), arg);
    });
  }
}

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

  Future<void> refresh() async {
    state = AsyncValue<T>.loading();
    state = await AsyncValue.guard<T>(() async {
      return await init(_generateLatestTag());
    });
  }
}

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

  Future<void> refresh() async {
    state = AsyncValue<T>.loading();
    state = await AsyncValue.guard<T>(() async {
      return await init(_generateLatestTag(), arg);
    });
  }
}
