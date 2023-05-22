import 'package:flutter/animation.dart';

import 'loading_on.dart';

typedef LoadingOnStart = void Function(String? message);

typedef HandleUncaughtError = void Function(
    bool isMain, Object error, StackTrace stack);

abstract class CamelotServiceConfig {
  factory CamelotServiceConfig({
    LoadingOnDialogController? controller,
    LoadingOnStart? loadingOnStart,
    VoidCallback? loadingOnEnd,
    HandleUncaughtError? handleUncaughtError,
  }) {
    return _CamelotServiceConfig(
      controller: controller ?? DefaultLoadingOnDialogController(),
      loadingOnStart: loadingOnStart,
      loadingOnEnd: loadingOnEnd,
      handleUncaughtError: handleUncaughtError,
    );
  }

  /// 在[loadingOn]的作業內，更新loading dialog的行為
  LoadingOnDialogController get controller;

  /// 用於使用[loadingOn]的工作開始前
  /// 請在此寫開啟loading dialog的邏輯
  LoadingOnStart? get loadingOnStart;

  /// 用於使用[loadingOn]的工作結束後
  /// 請在此寫關閉loading dialog的邏輯
  VoidCallback? get loadingOnEnd;

  HandleUncaughtError? get handleUncaughtError;
}

class _CamelotServiceConfig implements CamelotServiceConfig {
  const _CamelotServiceConfig({
    required this.controller,
    this.loadingOnStart,
    this.loadingOnEnd,
    this.handleUncaughtError,
  });

  @override
  final LoadingOnDialogController controller;

  @override
  final LoadingOnStart? loadingOnStart;

  @override
  final VoidCallback? loadingOnEnd;

  @override
  final HandleUncaughtError? handleUncaughtError;
}

class DefaultLoadingOnDialogController extends LoadingOnDialogController {
  @override
  setMessage(String msg) {}
}
