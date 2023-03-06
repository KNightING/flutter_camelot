import 'package:flutter/material.dart';

///
/// 參考 https://book.flutterchina.club/chapter6/keepalive.html#_6-8-2-keepalivewrapper
///
/// 改使用key做比對, 使用ValueKey or ObjectKey
class KeepAliveWrapper extends StatefulWidget {
  const KeepAliveWrapper({
    required super.key,
    required this.child,
  }) : super();

  final Widget child;

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepAliveWrapper oldWidget) {
    if (oldWidget.key != widget.key) {
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => true;
}
