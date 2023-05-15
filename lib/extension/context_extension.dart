import 'package:flutter/material.dart';
import '../widget/camelot.dart';

extension BuildContextExtension on BuildContext {
  CamelotState? get camelot => CamelotState.of(this);

  ThemeData? get theme => Theme.of(this);

  ColorScheme? get colorScheme => theme?.colorScheme;

  TextTheme? get textTheme => theme?.textTheme;

  ColorScheme get cs => colorScheme!;

  TextTheme get tt => textTheme!;

  (ThemeData t, ColorScheme cs, TextTheme tt) get t {
    final t = theme!;
    return (t, t.colorScheme, t.textTheme);
  }
}
