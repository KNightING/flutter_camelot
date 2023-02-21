import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../architecture/route_path.dart';

extension RoutePathWithGoRouterExtension on RoutePath {
  void go(BuildContext context, {Object? extra}) {
    context.go(path, extra: extra);
  }

  void push(BuildContext context, {Object? extra}) {
    context.push(path, extra: extra);
  }

  void pushReplacement(BuildContext context, {Object? extra}) {
    context.pushReplacement(path, extra: extra);
  }
}
