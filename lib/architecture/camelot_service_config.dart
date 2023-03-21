import 'loading_on.dart';

abstract class CamelotServiceConfig {
  factory CamelotServiceConfig({
    required LoadingOnDialogController controller,
    Function(String message)? loadingOnStart,
    Function? loadingOnEnd,
  }) = _CamelotServiceConfig;

  LoadingOnDialogController get controller;

  void Function(String message)? get loadingOnStart;

  Function? get loadingOnEnd;
}

class _CamelotServiceConfig implements CamelotServiceConfig {
  const _CamelotServiceConfig({
    required this.controller,
    this.loadingOnStart,
    this.loadingOnEnd,
  });

  @override
  final LoadingOnDialogController controller;

  @override
  final Function(String message)? loadingOnStart;

  @override
  final Function? loadingOnEnd;
}

class DefaultLoadingOnDialogController extends LoadingOnDialogController {
  @override
  setMessage(String msg) {}
}
