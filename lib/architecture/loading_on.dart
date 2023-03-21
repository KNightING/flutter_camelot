import 'package:flutter_camelot/architecture/camelot_service.dart';
import 'package:flutter_camelot/extension/kotlin_like_extension.dart';

typedef LoadingOnWork<T> = Future<T> Function(
    LoadingOnDialogController controller);

abstract class LoadingOnDialogController {
  setMessage(String msg);
}

Future<T?> loadingOn<T>(
  LoadingOnWork<T> work, {
  String message = "loading...",
}) async {
  return await CamelotService().config.let((config) async {
    try {
      final controller = config.controller;
      config.loadingOnStart?.call(message);
      return await work(controller);
    } finally {
      config.loadingOnEnd?.call();
    }
  });
}
