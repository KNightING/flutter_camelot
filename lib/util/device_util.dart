import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class CamelotDeviceUtil {
  /// 螢幕轉橫向
  static Future<void> landscape() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// 螢幕轉直向
  static Future<void> portrait() async {
    WidgetsFlutterBinding.ensureInitialized();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static setBrowserTitle(String title) {
    if (kIsWeb) {
      SystemChrome.setApplicationSwitcherDescription(
          ApplicationSwitcherDescription(
        label: title,
      ));
    }
  }

  static double get textScaleFactor {
    // View.of(context).platformDispatcher.textScaleFactor if a BuildContext is available, otherwise:
    return WidgetsBinding.instance.platformDispatcher.textScaleFactor;
  }

  static Brightness get brightness {
    return WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  static Locale get locale {
    return WidgetsBinding.instance.platformDispatcher.locale;
  }
}
