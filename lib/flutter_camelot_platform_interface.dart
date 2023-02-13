import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_camelot_method_channel.dart';

abstract class FlutterCamelotPlatform extends PlatformInterface {
  /// Constructs a FlutterCamelotPlatform.
  FlutterCamelotPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterCamelotPlatform _instance = MethodChannelFlutterCamelot();

  /// The default instance of [FlutterCamelotPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterCamelot].
  static FlutterCamelotPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterCamelotPlatform] when
  /// they register themselves.
  static set instance(FlutterCamelotPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
