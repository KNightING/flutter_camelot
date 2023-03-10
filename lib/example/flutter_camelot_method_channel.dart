import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_camelot_platform_interface.dart';

/// An implementation of [FlutterCamelotPlatform] that uses method channels.
class MethodChannelFlutterCamelot extends FlutterCamelotPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_camelot');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
