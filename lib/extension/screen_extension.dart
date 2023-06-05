import 'package:flutter/material.dart';

import '../architecture.dart';

extension ScreenExtension on num {
  // double vh(BuildContext context){
  //   return View.of(context).devicePixelRatio;
  // }

  double get vh {
    return Camelot().screenHeight * (this / 100);
  }

  double get vw {
    return Camelot().screenWidth * (this / 100);
  }
}
