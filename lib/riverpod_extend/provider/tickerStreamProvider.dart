import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<DateTime> tickerStreamProvider({required Duration duration}) {
  return StreamProvider<DateTime>((ref) async* {
    var now = DateTime.now();
    yield now;
    if (duration.inSeconds >= 60 && now.second != 0) {
      // 校正
      await Future.delayed(Duration(seconds: 60 - now.second));
      yield DateTime.now();
    }

    final ticker = Stream.periodic(duration, (x) => DateTime.now());
    final listen = ticker.listen((event) {});
    ref.onDispose(() {
      listen.cancel();
    });

    await for (final dateTime in ticker) {
      yield dateTime;
    }
  });
}
