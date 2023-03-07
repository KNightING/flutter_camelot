import 'package:flutter/material.dart';

///
/// 設定寬高的容許值，並控制在上下限內
///
class CamelotConstrainedBox extends StatelessWidget {
  const CamelotConstrainedBox({
    Key? key,
    required this.child,
    required this.lowerLimitWidth,
    this.allowableWidth,
    required this.upperLimitWidth,
    required this.lowerLimitHeight,
    this.allowableHeight,
    required this.upperLimitHeight,
  })  : _allowableWidth = allowableWidth ?? upperLimitWidth,
        _allowableHeight = allowableHeight ?? upperLimitHeight,
        super(key: key);

  factory CamelotConstrainedBox.width({
    Key? key,
    required Widget child,
    required double lowerLimitWidth,
    required double allowableWidth,
    required double upperLimitWidth,
  }) {
    return CamelotConstrainedBox(
        key: key,
        lowerLimitWidth: lowerLimitWidth,
        allowableWidth: allowableWidth,
        upperLimitWidth: upperLimitWidth,
        lowerLimitHeight: 0,
        upperLimitHeight: double.infinity,
        child: child);
  }

  factory CamelotConstrainedBox.height({
    Key? key,
    required Widget child,
    required double lowerLimitHeight,
    required double allowableHeight,
    required double upperLimitHeight,
  }) {
    return CamelotConstrainedBox(
        key: key,
        lowerLimitWidth: 0,
        upperLimitWidth: double.infinity,
        lowerLimitHeight: lowerLimitHeight,
        allowableHeight: allowableHeight,
        upperLimitHeight: upperLimitHeight,
        child: child);
  }

  final Widget child;

  final double lowerLimitWidth;

  final double? allowableWidth;

  final double _allowableWidth;

  final double upperLimitWidth;

  final double lowerLimitHeight;

  final double? allowableHeight;

  final double upperLimitHeight;

  final double _allowableHeight;

  @override
  Widget build(BuildContext context) {
    final maxWidth = _allowableWidth > lowerLimitWidth
        ? (_allowableWidth > upperLimitWidth
            ? upperLimitWidth
            : _allowableWidth)
        : lowerLimitWidth;

    final maxHeight = _allowableHeight > lowerLimitHeight
        ? (_allowableHeight > upperLimitHeight
            ? upperLimitHeight
            : _allowableHeight)
        : lowerLimitHeight;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: lowerLimitWidth,
        maxWidth: maxWidth,
        minHeight: lowerLimitHeight,
        maxHeight: maxHeight,
      ),
      child: child,
    );
  }
}
