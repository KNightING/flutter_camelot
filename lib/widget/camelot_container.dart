import 'package:flutter/material.dart';
import 'package:flutter_camelot/extension/context_extension.dart';
import 'package:flutter_camelot/extension/kotlin_like_extension.dart';
import 'package:flutter_camelot/log/camelot_log.dart';

import 'camelot_limit_box.dart';

typedef CContainer = CamelotContainer;

class CamelotContainer extends StatelessWidget {
  /// 整合 [Padding], [InkWell], [Ink], [Material], [CamelotLimitBox]
  const CamelotContainer(
      {Key? key,
      required this.child,
      this.useInkWell = true,
      this.showBorder = true,
      this.color = Colors.transparent,
      this.gradient,
      this.backgroundColor = Colors.transparent,
      this.borderRadius = BorderRadius.zero,
      this.side = BorderSide.none,
      this.border,
      this.onTap,
      this.padding = EdgeInsets.zero,
      this.margin = EdgeInsets.zero,
      this.mouseCursor,
      this.focusColor,
      this.hoverColor,
      this.highlightColor,
      this.overlayColor,
      this.splashColor,
      this.splashFactory,
      this.elevation = 0.0,
      this.shadowColor,
      this.boxShadow,
      this.onDoubleTap,
      this.onLongPress,
      this.onTapDown,
      this.onTapUp,
      this.onTapCancel,
      this.onHighlightChanged,
      this.onHover,
      CamelotLimitBoxSizeMode? widthMode,
      this.lowerLimitWidth = 0,
      this.width,
      this.upperLimitWidth = double.infinity,
      CamelotLimitBoxSizeMode? heightMode,
      this.lowerLimitHeight = 0,
      this.height,
      this.upperLimitHeight = double.infinity,
      this.alignment})
      : widthMode = widthMode ??
            (width == null
                ? CamelotLimitBoxSizeMode.wrapContent
                : CamelotLimitBoxSizeMode.limit),
        heightMode = heightMode ??
            (height == null
                ? CamelotLimitBoxSizeMode.wrapContent
                : CamelotLimitBoxSizeMode.limit),
        super(key: key);

  final Widget child;

  final bool useInkWell;

  final double elevation;

  // when elevation is 0 that is not work.
  final Color? shadowColor;

  final bool showBorder;

  /// [gradient] 優先於 [color]
  final Color color;

  final Gradient? gradient;

  final Color backgroundColor;

  final BorderSide side;

  // 有border會無視side
  final BoxBorder? border;

  final BorderRadius borderRadius;

  final VoidCallback? onTap;

  final VoidCallback? onDoubleTap;

  final VoidCallback? onLongPress;

  final void Function(TapDownDetails)? onTapDown;

  final void Function(TapUpDetails)? onTapUp;

  final VoidCallback? onTapCancel;

  final void Function(bool)? onHighlightChanged;

  final void Function(bool)? onHover;

  final EdgeInsets padding;

  final EdgeInsets margin;

  final MouseCursor? mouseCursor;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final MaterialStateProperty<Color?>? overlayColor;

  final Color? splashColor;

  final InteractiveInkFeatureFactory? splashFactory;

  // when color is transparent that boxShadow is not work.
  final List<BoxShadow>? boxShadow;

  final CamelotLimitBoxSizeMode widthMode;

  final double lowerLimitWidth;

  final double? width;

  final double upperLimitWidth;

  final CamelotLimitBoxSizeMode heightMode;

  final double lowerLimitHeight;

  final double? height;

  final double upperLimitHeight;

  final Alignment? alignment;

  EdgeInsets? getBoxShadowPadding() {
    var leftPadding = 0.0;
    var topPadding = 0.0;
    var rightPadding = 0.0;
    var bottomPadding = 0.0;

    boxShadow?.forEach((shadow) {
      final shadowPadding = shadow.blurRadius * 1.5;
      final xPadding = shadow.offset.dx.abs() + shadowPadding;
      final yPadding = shadow.offset.dy.abs() + shadowPadding;

      if (leftPadding == 0) {
        leftPadding = shadowPadding - shadow.offset.dx;
        if (leftPadding < 0) leftPadding = 0;
      }

      if (rightPadding == 0) {
        rightPadding = shadowPadding + shadow.offset.dx;
      }

      if (topPadding == 0) {
        topPadding = shadowPadding - shadow.offset.dy;
        if (topPadding < 0) topPadding = 0;
      }

      if (bottomPadding == 0) {
        bottomPadding = shadowPadding + shadow.offset.dy;
      }

      if (shadow.offset.dx < 0 && xPadding > leftPadding) {
        leftPadding = xPadding;
      }

      if (shadow.offset.dx > 0 && xPadding > rightPadding) {
        rightPadding = xPadding;
      }

      if (shadow.offset.dy < 0 && yPadding > topPadding) {
        topPadding = yPadding;
      }

      if (shadow.offset.dy > 0 && yPadding > bottomPadding) {
        bottomPadding = yPadding;
      }
    });

    if (leftPadding > 0 ||
        topPadding > 0 ||
        rightPadding > 0 ||
        bottomPadding > 0) {
      return EdgeInsets.only(
        left: leftPadding,
        top: topPadding,
        right: rightPadding,
        bottom: bottomPadding,
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _child = child;

    alignment?.let((alignment) {
      _child = Align(
        alignment: alignment,
        child: _child,
      );
    });

    _child = CamelotLimitBox(
      widthMode: widthMode,
      lowerLimitWidth: lowerLimitWidth,
      itemWidth: width,
      upperLimitWidth: upperLimitWidth,
      heightMode: heightMode,
      lowerLimitHeight: lowerLimitHeight,
      itemHeight: height,
      upperLimitHeight: upperLimitHeight,
      child: _child,
    );

    if (padding != EdgeInsets.zero) {
      _child = Padding(
        padding: padding,
        child: _child,
      );
    }

    if (useInkWell) {
      _child = InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        onHover: onHover,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        onHighlightChanged: onHighlightChanged,
        mouseCursor: mouseCursor,
        focusColor: focusColor,
        highlightColor: highlightColor,
        overlayColor: overlayColor,
        splashColor: splashColor,
        splashFactory: splashFactory,
        child: _child,
      );
    } else {
      _child = GestureDetector(
        onTap: onTap,
        onLongPress: onLongPress,
        onDoubleTap: onDoubleTap,
        onTapUp: onTapUp,
        onTapDown: onTapDown,
        onTapCancel: onTapCancel,
        child: MouseRegion(
          cursor: mouseCursor ?? SystemMouseCursors.click,
          child: _child,
        ),
      );
    }

    if (border != null ||
        color != Colors.transparent ||
        boxShadow != null ||
        gradient != null) {
      final borderIsUniform = border?.isUniform ?? false;

      _child = Ink(
        decoration: BoxDecoration(
          color: gradient != null ? null : color,
          gradient: gradient,
          borderRadius: borderRadius,
          border: (showBorder && borderIsUniform) ? border : null,
          boxShadow: boxShadow,
        ),
        child: _child,
      );

      if (!borderIsUniform) {
        _child = ClipRRect(
          borderRadius: borderRadius,
          child: DecoratedBox(
            decoration: BoxDecoration(border: border),
            child: _child,
          ),
        );
      }

      final boxShadowPadding = getBoxShadowPadding();
      if (boxShadowPadding != null) {
        _child = Padding(
          padding: boxShadowPadding,
          child: _child,
        );
      }
    }

    _child = Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: shadowColor ?? context.colorScheme?.shadow,
      shape: RoundedRectangleBorder(
        side: showBorder && border == null ? side : BorderSide.none,
        borderRadius: borderRadius,
      ),
      child: _child,
    );

    if (margin != EdgeInsets.zero) {
      _child = Padding(
        padding: margin,
        child: _child,
      );
    }

    return _child;
  }
}
