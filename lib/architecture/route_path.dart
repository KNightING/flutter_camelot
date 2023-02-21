typedef RoutePathCompare = bool Function(String target);

class RoutePath {
  RoutePath(this.path, {required this.compare});

  final String path;

  final RoutePathCompare compare;

  @override
  String toString() {
    return path;
  }
}
