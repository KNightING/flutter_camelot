import 'package:flutter/animation.dart';

import 'loading_on.dart';

typedef LoadingOnStart = void Function(String message);

typedef HandleUncaughtError = void Function(
    bool isMain, Object error, StackTrace stack);

abstract class CamelotServiceConfig {
  factory CamelotServiceConfig({
    required LoadingOnDialogController controller,
    LoadingOnStart? loadingOnStart,
    VoidCallback loadingOnEnd,
    HandleUncaughtError? handleUncaughtError,
  }) = _CamelotServiceConfig;

  LoadingOnDialogController get controller;

  LoadingOnStart? get loadingOnStart;

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
