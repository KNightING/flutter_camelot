import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_camelot/camelot_run_app.dart';
import 'package:flutter_camelot/example/flutter_camelot.dart';
import 'package:flutter_camelot/log/camelot_log.dart';
import 'package:flutter_camelot/util/device_util.dart';
import 'package:flutter_camelot/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  camelotRunApp(
    initAsyncApp: () async {
      await CamelotDeviceUtil.landscape();
    },
    app: const ProviderScope(child: MyApp()),
  );
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
                CamelotContainer(
                  onTap: () {
                    CLog.debug('message');
                    CLog.info('message');
                    CLog.warn('message');
                    CLog.error('message');
                  },
                  color: Colors.redAccent,
                  splashColor: Colors.deepOrange,
                  gradient: const LinearGradient(
                    colors: [
                      Colors.redAccent,
                      Colors.purple,
                    ],
                  ),
                  border: Border.all(color: Colors.white),
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(20),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(-3, -3),
                      color: Colors.tealAccent,
                      blurRadius: 6,
                    ),
                    BoxShadow(
                      offset: Offset(3, 3),
                      color: Colors.blueAccent,
                      blurRadius: 6,
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  child: Text('Camelot Container'),
                ),
                CamelotIconButton(
                  Icons.edit,
                  color: Colors.red,
                  size: 50,
                  splashColor: Colors.teal,
                  iconSize: 20,
                  onPressed: () {},
                ),
                Text('Running on: $_platformVersion\n'),
                SizedBox(
                  width: 100,
                  child: CamelotTextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        gapPadding: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
