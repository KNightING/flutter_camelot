import 'dart:async';

/// run and retry [action] until return not null by [action] or retry times equals [times]
/// only last time will throw the error.
FutureOr<T?> runRetry<T>(
  int times, {
  required FutureOr<T?> Function() action,
  Duration? delayed,
}) async {
  int mTimes = 0;
  T? mData;

  while (mTimes < times && mData == null) {
    if (mTimes != 0 && delayed != null) {
      await Future.delayed(delayed);
    }
    try {
      mData = await action();
    } catch (error) {
      if (mTimes + 1 == times) {
        rethrow;
      }
    }
    mTimes++;
  }
  return mData;
}
