import 'package:flutter_riverpod/flutter_riverpod.dart';

StreamProvider<DateTime> tickerStreamProvider(
    {required Duration duration, bool correctingTime = false}) {
  return StreamProvider<DateTime>((ref) async* {
    var now = DateTime.now();
    yield now;

    // 是否效正時間
    if (correctingTime) {
      var correctingSeconds = 0;
      var correctingMinutes = 0;
      var correctingHours = 0;

      // 校正至分鐘
      if (duration.inSeconds >= 60) {
        correctingSeconds = 60 - now.second;

        // 校正至小時
        if (duration.inMinutes >= 60) {
          correctingMinutes = 60 - now.minute;

          // 校正至天
          if (duration.inHours >= 24) {
            correctingHours = 24 - now.hour;
          }
        }

        await Future.delayed(
          Duration(
            hours: correctingHours,
            minutes: correctingMinutes,
            seconds: correctingSeconds,
          ),
        );
        yield DateTime.now();
      }
    }

    final ticker = Stream.periodic(duration, (x) => DateTime.now());
    ref.onDispose(() {});
    yield* ticker;

    // 下同yield*
    // await for (final dateTime in ticker) {
    //   yield dateTime;
    // }
  });
}
