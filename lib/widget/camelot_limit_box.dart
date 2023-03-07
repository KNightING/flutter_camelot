import 'package:flutter/material.dart';

///
/// 設定寬高的容許值，並控制在上下限內
/// 適合用在寬高是響應式時
///
class CamelotLimitBox extends StatelessWidget {
  const CamelotLimitBox({
    Key? key,
    required this.child,
    required this.lowerLimitWidth,
    this.width,
    required this.upperLimitWidth,
    required this.lowerLimitHeight,
    this.height,
    required this.upperLimitHeight,
  })  : _width = width ?? upperLimitWidth,
        _height = height ?? upperLimitHeight,
        super(key: key);

  factory CamelotLimitBox.width({
    Key? key,
    required Widget child,
    required double lowerLimitWidth,
    required double width,
    required double upperLimitWidth,
  }) {
    return CamelotLimitBox(
        key: key,
        lowerLimitWidth: lowerLimitWidth,
        width: width,
        upperLimitWidth: upperLimitWidth,
        lowerLimitHeight: 0,
        upperLimitHeight: double.infinity,
        child: child);
  }

  factory CamelotLimitBox.height({
    Key? key,
    required Widget child,
    required double lowerLimitHeight,
    required double height,
    required double upperLimitHeight,
  }) {
    return CamelotLimitBox(
        key: key,
        lowerLimitWidth: 0,
        upperLimitWidth: double.infinity,
        lowerLimitHeight: lowerLimitHeight,
        height: height,
        upperLimitHeight: upperLimitHeight,
        child: child);
  }

  final Widget child;

  final double lowerLimitWidth;

  final double? width;

  final double _width;

  final double upperLimitWidth;

  final double lowerLimitHeight;

  final double? height;

  final double _height;

  final double upperLimitHeight;

  @override
  Widget build(BuildContext context) {
    final useWidth = _width > lowerLimitWidth
        ? (_width > upperLimitWidth ? upperLimitWidth : _width)
        : lowerLimitWidth;

    final useHeight = _height > lowerLimitHeight
        ? (_height > upperLimitHeight ? upperLimitHeight : _height)
        : lowerLimitHeight;

    return SizedBox(
      width: useWidth,
      height: useHeight,
      child: child,
    );
  }
}
