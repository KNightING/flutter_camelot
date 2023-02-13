
import 'package:flutter/material.dart';

extension ColorExtension on Color {
  TextStyle? textStyle(TextStyle? style) {
    return style?.copyWith(color: this);
  }
}
