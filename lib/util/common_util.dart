import 'dart:async';
import 'dart:ui';

class CommonUtil {
  /// 防抖動
  /// 時間內連續觸發事件時, 只會觸發最後一次
  /// ex. Scrollbar滾動時callback
  static VoidCallback debounce(
      {required VoidCallback func, int delayMilliseconds = 250}) {
    Timer? timer;

    return () {
      timer?.cancel();
      timer = Timer(Duration(milliseconds: delayMilliseconds), func);
    };
  }

  /// 節閥
  /// 時間內只會執行一次
  static VoidCallback throttle(
      {required VoidCallback func, int timeoutMilliseconds = 250}) {
    int? last;
    Timer? timer;

    return () {
      final int now = DateTime.now().millisecond;

      if (last != null && now < last! + timeoutMilliseconds) {
        timer?.cancel();
        timer = Timer(Duration(milliseconds: timeoutMilliseconds), () {
          last = now;
          func();
        });
      } else {
        last = now;
        func();
      }
    };
  }
}
