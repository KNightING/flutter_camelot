import 'package:flutter/material.dart';

// 其實幾乎可以使用OutlineButton做到差不多的事
class CamelotBorderBox extends StatelessWidget {
  const CamelotBorderBox({
    Key? key,
    required this.child,
    this.showBorder = true,
    this.color = Colors.transparent,
    this.backgroundColor = Colors.transparent,
    this.borderRadius = BorderRadius.zero,
    this.side = BorderSide.none,
    this.border,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.mouseCursor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.overlayColor,
    this.splashColor,
    this.splashFactory,
    this.elevation = 0.0,
    this.boxShadow,
  }) : super(key: key);

  final Widget child;

  final double elevation;

  final bool showBorder;

  final Color color;

  final Color backgroundColor;

  final BorderSide side;

  // 有border會無視side
  final BoxBorder? border;

  final BorderRadius borderRadius;

  final VoidCallback? onTap;

  final EdgeInsets padding;

  final MouseCursor? mouseCursor;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final MaterialStateProperty<Color?>? overlayColor;

  final Color? splashColor;

  final InteractiveInkFeatureFactory? splashFactory;

  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    var _child = child;

    if (padding != EdgeInsets.zero) {
      _child = Padding(
        padding: padding,
        child: _child,
      );
    }

    if (onTap != null) {
      _child = InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        mouseCursor: mouseCursor,
        focusColor: focusColor,
        highlightColor: highlightColor,
        overlayColor: overlayColor,
        splashColor: splashColor,
        splashFactory: splashFactory,
        child: _child,
      );
    }

    if (border != null) {
      _child = Ink(
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: showBorder ? border : null,
          boxShadow: boxShadow,
        ),
        child: _child,
      );
    }

    return Material(
      color: backgroundColor,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        side: showBorder && border == null ? side : BorderSide.none,
        borderRadius: borderRadius,
      ),
      child: _child,
    );
  }
}
