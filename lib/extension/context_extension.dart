import 'package:flutter/material.dart';
import '../widget/camelot.dart';

extension BuildContextExtension on BuildContext {
  CamelotState? get camelot => CamelotState.of(this);

  ThemeData? get theme => Theme.of(this);

  ColorScheme? get colorScheme => theme?.colorScheme;

  TextTheme? get textTheme => theme?.textTheme;

  ThemeData get t => theme!;

  ColorScheme get cs => colorScheme!;

  TextTheme get tt => textTheme!;
}
