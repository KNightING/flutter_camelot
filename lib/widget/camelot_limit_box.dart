import 'package:flutter/material.dart';

enum CamelotLimitBoxSizeMode {
  limit,
  wrapContent,
}

class CamelotLimitBox extends StatelessWidget {
  /// 設定寬高的容許值，並控制在上下限內
  /// 適合用在寬高是響應式時
  /// width/height 為 null時 會同upper
  const CamelotLimitBox({
    Key? key,
    required this.child,
    this.widthMode = CamelotLimitBoxSizeMode.limit,
    required this.lowerLimitWidth,
    this.width,
    required this.upperLimitWidth,
    this.heightMode = CamelotLimitBoxSizeMode.limit,
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
        heightMode: CamelotLimitBoxSizeMode.wrapContent,
        lowerLimitHeight: 0,
        upperLimitHeight: double.infinity,
        child: child);
  }

  factory CamelotLimitBox.maxWidth({
    Key? key,
    required Widget child,
    required double upperLimitWidth,
  }) {
    return CamelotLimitBox.width(
      key: key,
      lowerLimitWidth: 0,
      width: double.infinity,
      upperLimitWidth: upperLimitWidth,
      child: child,
    );
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
        widthMode: CamelotLimitBoxSizeMode.wrapContent,
        lowerLimitWidth: 0,
        upperLimitWidth: double.infinity,
        lowerLimitHeight: lowerLimitHeight,
        height: height,
        upperLimitHeight: upperLimitHeight,
        child: child);
  }

  factory CamelotLimitBox.maxHeight({
    Key? key,
    required Widget child,
    required double upperLimitHeight,
  }) {
    return CamelotLimitBox.height(
      key: key,
      lowerLimitHeight: 0,
      height: double.infinity,
      upperLimitHeight: upperLimitHeight,
      child: child,
    );
  }

  final Widget child;

  final CamelotLimitBoxSizeMode widthMode;

  final double lowerLimitWidth;

  final double? width;

  final double _width;

  final double upperLimitWidth;

  final CamelotLimitBoxSizeMode heightMode;

  final double lowerLimitHeight;

  final double? height;

  final double _height;

  final double upperLimitHeight;

  @override
  Widget build(BuildContext context) {
    final double? useWidth;
    if (widthMode == CamelotLimitBoxSizeMode.limit) {
      useWidth = _width > lowerLimitWidth
          ? (_width > upperLimitWidth ? upperLimitWidth : _width)
          : lowerLimitWidth;
    } else {
      useWidth = null;
    }

    final double? useHeight;

    if (heightMode == CamelotLimitBoxSizeMode.limit) {
      useHeight = _height > lowerLimitHeight
          ? (_height > upperLimitHeight ? upperLimitHeight : _height)
          : lowerLimitHeight;
    } else {
      useHeight = null;
    }

    return SizedBox(
      width: useWidth,
      height: useHeight,
      child: child,
    );
  }
}
