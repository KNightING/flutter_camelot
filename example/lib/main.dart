import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_camelot/architecture.dart';
import 'package:flutter_camelot/camelot_run_app.dart';
import 'package:flutter_camelot/example/flutter_camelot.dart';
import 'package:flutter_camelot/extension.dart';
import 'package:flutter_camelot/log/camelot_log.dart';
import 'package:flutter_camelot/util/device_util.dart';
import 'package:flutter_camelot/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  camelotRunApp(
    exitOnError: false,
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

  demoOnIntResult(OnResult<int> onResult) {
    onResult.successful(data: 0);
    onResult.failure(message: 'failure message');
  }

  demoOnBoolResult(OnResult<bool> onResult) {
    onResult.successfulData();
    onResult.failureData(message: 'failure message');
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
          builder: (BuildContext context) {
            final mediaQuery = MediaQuery.of(context);

            return Scaffold(
              appBar: AppBar(
                title: const Text('Plugin example app'),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CamelotContainer(
                          onTap: () {
                            CLog.debug('message');
                            CLog.info('message');
                            CLog.warn('message');
                            CLog.error('message');
                            CLog.debug(
                                '${View.of(context).physicalSize.width}');
                            CLog.debug(
                                '${View.of(context).physicalSize.height}');
                            CLog.debug(
                                '${View.of(context).physicalSize.aspectRatio}');
                            CLog.debug('${View.of(context).devicePixelRatio}');
                            CLog.debug('${20.vh}');
                            CLog.debug('${25.vw}');

                            CLog.debug('${View.of(context).viewPadding}');
                            CLog.debug('${View.of(context).viewInsets}');
                            CLog.debug('${mediaQuery.size}');
                            CLog.debug('${mediaQuery.size.height * 0.2}');
                            CLog.debug('${mediaQuery.size.width * 0.25}');
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
                              offset: Offset(-5, -5),
                              color: Colors.tealAccent,
                              blurRadius: 20,
                            ),
                            BoxShadow(
                              offset: Offset(5, 5),
                              color: Colors.blueAccent,
                              blurRadius: 20,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          lowerLimitHeight: 120,
                          height: 25.vh,
                          upperLimitHeight: 150,
                          lowerLimitWidth: 170,
                          width: 30.vw,
                          upperLimitWidth: 300,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Running on: $_platformVersion',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '''
Camelot Container
W:${constraints.maxWidth.toStringAsFixed(2)}
H:${constraints.maxHeight.toStringAsFixed(2)}
                                    ''',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        CamelotContainer(
                          onTap: () {},
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
                              offset: Offset(3, 3),
                              color: Colors.blueAccent,
                              blurRadius: 30,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15),
                          lowerLimitHeight: 120,
                          height: 25.vh,
                          upperLimitHeight: 150,
                          lowerLimitWidth: 170,
                          width: 30.vw,
                          upperLimitWidth: 300,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Running on: $_platformVersion',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '''
Camelot Container
W:${constraints.maxWidth.toStringAsFixed(2)}
H:${constraints.maxHeight.toStringAsFixed(2)}
                                    ''',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    CamelotIconButton(
                      Icons.edit,
                      color: Colors.red,
                      size: 50,
                      splashColor: Colors.teal,
                      iconSize: 20,
                      onPressed: () {},
                    ),
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
            );
          }),
    );
  }
}
