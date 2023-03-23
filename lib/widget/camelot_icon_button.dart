import 'package:flutter/material.dart';
import 'package:flutter_camelot/extension/context_extension.dart';

class CamelotIconButton extends StatelessWidget {
  const CamelotIconButton(
    this.icon, {
    Key? key,
    this.size = 34,
    this.iconSize = 26,
    this.padding = EdgeInsets.zero,
    required this.onPressed,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.disabledColor,
    this.tooltip,
    this.isSelected,
    this.selectedIcon,
    this.mouseCursor,
    this.focusNode,
  }) : super(key: key);

  final IconData icon;

  final double size;

  final double iconSize;

  final EdgeInsetsGeometry padding;

  final VoidCallback onPressed;

  final Color? color;

  final Color? focusColor;

  final Color? hoverColor;

  final Color? highlightColor;

  final Color? splashColor;

  final Color? disabledColor;

  final String? tooltip;

  final bool? isSelected;

  final Widget? selectedIcon;

  final MouseCursor? mouseCursor;

  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return IconButton(
      padding: padding,
      alignment: Alignment.center,
      constraints: BoxConstraints.tight(Size(size, size)),
      iconSize: iconSize,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      // 經測試 splashColor參數無效，會吃到color的參數
      color: splashColor,
      splashColor: splashColor,
      disabledColor: disabledColor,
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(
        icon,
        color: color ?? cs?.primary,
      ),
      isSelected: isSelected,
      selectedIcon: selectedIcon,
      focusNode: focusNode,
      mouseCursor: mouseCursor,
    );
  }
}
