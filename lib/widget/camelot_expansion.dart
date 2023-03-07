import 'package:flutter/material.dart';

class CamelotExpansion extends StatelessWidget {
  const CamelotExpansion({
    Key? key,
    required this.isExpand,
    required this.child,
    this.openDurationMS = 400,
    this.closeDurationMS = 600,
    this.collapseChild,
  }) : super(key: key);

  final bool isExpand;

  final int openDurationMS;

  final int closeDurationMS;

  final Widget? collapseChild;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: isExpand
          ? Duration(milliseconds: openDurationMS)
          : Duration(milliseconds: closeDurationMS),
      curve: Curves.fastOutSlowIn,
      child: Container(
        child: isExpand ? child : collapseChild,
      ),
    );
  }
}
