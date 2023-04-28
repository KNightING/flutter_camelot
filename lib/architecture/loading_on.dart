import 'package:flutter/animation.dart';
import 'package:flutter_camelot/architecture.dart';
import 'package:flutter_camelot/extension/kotlin_like_extension.dart';

typedef LoadingOnWork<T> = Future<T> Function(LoadingOnController controller);

class LoadingOnController {
  LoadingOnController({
    required this.dialogController,
    required this.endController,
  });

  LoadingOnDialogController dialogController;

  LoadingOnEndController endController;
}

abstract class LoadingOnDialogController {
  setMessage(String msg);
}

class LoadingOnEndController {
  VoidCallback? onEnd;
}

/// 包裝[CamelotServiceConfig.loadingOnStart]與[CamelotServiceConfig.loadingOnEnd]
///
/// 如果需要[work]內有用到與[CamelotServiceConfig.loadingOnEnd]衝突的行為，
/// 請設定在[LoadingOnController.endController]的[LoadingOnEndController.onEnd]，
/// 例如: 會觸發到關閉LoadingDialog等...
/// 或也可以在await [loadingOn]之後進行該行為
Future<T> loadingOn<T>(
  LoadingOnWork<T> work, {
  String message = "loading...",
}) async {
  return await CamelotService().config.let((config) async {
    final endController = LoadingOnEndController();
    try {
      final dialogController = config.controller;
      config.loadingOnStart?.call(message);
      return await work(
        LoadingOnController(
          dialogController: dialogController,
          endController: endController,
        ),
      );
    } finally {
      config.loadingOnEnd?.call();
      endController.onEnd?.call();
    }
  });
}
