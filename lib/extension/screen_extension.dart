import 'package:flutter/material.dart';

extension ScreenExtension on num {
  // double vh(BuildContext context){
  //   return View.of(context).devicePixelRatio;
  // }

  double get vh {
    return WidgetsBinding.instance.window.physicalSize.height * (this / 100);
  }

  double get vw {
    return WidgetsBinding.instance.window.physicalSize.width * (this / 100);
  }
}
