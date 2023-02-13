import 'package:flutter/services.dart';
import 'package:flutter_camelot/example/flutter_camelot_method_channel.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelFlutterCamelot platform = MethodChannelFlutterCamelot();
  const MethodChannel channel = MethodChannel('flutter_camelot');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
