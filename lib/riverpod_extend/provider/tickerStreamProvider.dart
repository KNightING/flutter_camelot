import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<DateTime> tickerStreamProvider({required Duration duration}) {
  return StreamProvider<DateTime>((ref) async* {
    final ticker = Stream.periodic(duration, (x) => DateTime.now());
    ref.onDispose(() {});
    yield DateTime.now();
    await for (final dateTime in ticker) {
      yield dateTime;
    }
  });
}
