import 'package:flutter/animation.dart';
import 'package:flutter_camelot/architecture/camelot_service.dart';
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
