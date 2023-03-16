import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_camelot/example/flutter_camelot.dart';
import 'package:flutter_camelot/log/camelot_log.dart';
import 'package:flutter_camelot/widget/camelot.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterCamelotPlugin = FlutterCamelot();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterCamelotPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF175D6F),
          brightness: Brightness.dark,
          primary: const Color(0xFF175D6F),
        ),
      ),
      home: Camelot(
        logPanelHeight: 300,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  iconSize: 20,
                  splashRadius: 35,
                  constraints: BoxConstraints.tight(
                    const Size(35, 35),
                  ),
                  icon: const Icon(
                    Icons.edit,
                  ),
                  onPressed: () {
                    CLog.debug('debug');
                    CLog.info('info');
                    CLog.warn('warn');
                    CLog.error('error');
                    try {
                      throw FlutterError('test exception');
                    } on Error catch (e, s) {
                      CLog.errorAndStackTrace(e, s);
                    }
                  },
                ),
                Text('Running on: $_platformVersion\n'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
