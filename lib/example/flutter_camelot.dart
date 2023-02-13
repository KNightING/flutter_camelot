import 'flutter_camelot_platform_interface.dart';

class FlutterCamelot {
  Future<String?> getPlatformVersion() {
    return FlutterCamelotPlatform.instance.getPlatformVersion();
  }
}
