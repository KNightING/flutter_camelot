import 'package:flutter/material.dart';

enum CamelotLimitBoxSizeMode {
  limit,
  wrapContent,
}

class CamelotLimitBox extends SizedBox {
  /// 設定寬高的容許值，並控制在上下限內
  /// 適合用在寬高是響應式時
  /// width/height 為 null時 會同upper
  // const CamelotLimitBox({
  //   Key? key,
  //   required this.child,
  //   this.widthMode = CamelotLimitBoxSizeMode.limit,
  //   required this.lowerLimitWidth,
  //   this.width,
  //   required this.upperLimitWidth,
  //   this.heightMode = CamelotLimitBoxSizeMode.limit,
  //   required this.lowerLimitHeight,
  //   this.height,
  //   required this.upperLimitHeight,
  // })  : _width = width ?? upperLimitWidth,
  //       _height = height ?? upperLimitHeight,
  //       super(key: key);

  /// 設定寬高的容許值，並控制在上下限內
  /// 適合用在寬高是響應式時
  /// width/height 為 null時 會同upper
  const CamelotLimitBox({
    Key? key,
    required super.child,
    this.widthMode = CamelotLimitBoxSizeMode.limit,
    required this.lowerLimitWidth,
    this.itemWidth,
    required this.upperLimitWidth,
    this.heightMode = CamelotLimitBoxSizeMode.limit,
    required this.lowerLimitHeight,
    this.itemHeight,
    required this.upperLimitHeight,
  }) : super(
          key: key,
          width: widthMode == CamelotLimitBoxSizeMode.limit
              ? ((itemWidth ?? upperLimitWidth) > lowerLimitWidth
                  ? ((itemWidth ?? upperLimitWidth) > upperLimitWidth
                      ? upperLimitWidth
                      : (itemWidth ?? upperLimitWidth))
                  : lowerLimitWidth)
              : null,
          height: heightMode == CamelotLimitBoxSizeMode.limit
              ? ((itemHeight ?? upperLimitHeight) > lowerLimitHeight
                  ? ((itemHeight ?? upperLimitHeight) > upperLimitHeight
                      ? upperLimitHeight
                      : (itemHeight ?? upperLimitHeight))
                  : lowerLimitHeight)
              : null,
        );

  factory CamelotLimitBox.width({
    Key? key,
    required Widget child,
    required double lowerLimitWidth,
    required double itemWidth,
    required double upperLimitWidth,
  }) {
    return CamelotLimitBox(
        key: key,
        lowerLimitWidth: lowerLimitWidth,
        itemWidth: itemWidth,
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
      itemWidth: double.infinity,
      upperLimitWidth: upperLimitWidth,
      child: child,
    );
  }

  factory CamelotLimitBox.height({
    Key? key,
    required Widget child,
    required double lowerLimitHeight,
    required double itemHeight,
    required double upperLimitHeight,
  }) {
    return CamelotLimitBox(
        key: key,
        widthMode: CamelotLimitBoxSizeMode.wrapContent,
        lowerLimitWidth: 0,
        upperLimitWidth: double.infinity,
        lowerLimitHeight: lowerLimitHeight,
        itemHeight: itemHeight,
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
      itemHeight: double.infinity,
      upperLimitHeight: upperLimitHeight,
      child: child,
    );
  }

  //final Widget child;

  final CamelotLimitBoxSizeMode widthMode;

  final double lowerLimitWidth;

  final double? itemWidth;

  final double upperLimitWidth;

  final CamelotLimitBoxSizeMode heightMode;

  final double lowerLimitHeight;

  final double? itemHeight;

  final double upperLimitHeight;

// @override
// Widget build(BuildContext context) {
//   final double? useWidth;
//   if (widthMode == CamelotLimitBoxSizeMode.limit) {
//     useWidth = _width > lowerLimitWidth
//         ? (_width > upperLimitWidth ? upperLimitWidth : _width)
//         : lowerLimitWidth;
//   } else {
//     useWidth = null;
//   }
//
//   final double? useHeight;
//
//   if (heightMode == CamelotLimitBoxSizeMode.limit) {
//     useHeight = _height > lowerLimitHeight
//         ? (_height > upperLimitHeight ? upperLimitHeight : _height)
//         : lowerLimitHeight;
//   } else {
//     useHeight = null;
//   }
//
//   return SizedBox(
//     width: useWidth,
//     height: useHeight,
//     child: child,
//   );
// }
}
