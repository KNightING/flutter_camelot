import 'package:flutter_camelot/example/flutter_camelot_method_channel.dart';
import 'package:flutter_camelot/example/flutter_camelot_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_camelot/example/flutter_camelot.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterCamelotPlatform
    with MockPlatformInterfaceMixin
    implements FlutterCamelotPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterCamelotPlatform initialPlatform =
      FlutterCamelotPlatform.instance;

  test('$MethodChannelFlutterCamelot is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterCamelot>());
  });

  test('getPlatformVersion', () async {
    FlutterCamelot flutterCamelotPlugin = FlutterCamelot();
    MockFlutterCamelotPlatform fakePlatform = MockFlutterCamelotPlatform();
    FlutterCamelotPlatform.instance = fakePlatform;

    expect(await flutterCamelotPlugin.getPlatformVersion(), '42');
  });
}
