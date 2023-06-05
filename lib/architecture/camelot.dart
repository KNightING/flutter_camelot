import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../architecture.dart';

class Camelot {
  static final Camelot _singleton = Camelot._();

  Camelot._();

  @internal
  factory Camelot() {
    return _singleton;
  }

  CamelotConfig config = CamelotConfig(
    controller: DefaultLoadingOnDialogController(),
  );

   double get screenWidth => mediaQuery.size.width / mediaQuery.devicePixelRatio;

   double get screenHeight  => mediaQuery.size.height / mediaQuery.devicePixelRatio;

  late MediaQueryData mediaQuery;
}
