import 'package:flutter/material.dart';

class Camelot extends StatefulWidget {
  const Camelot({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<Camelot> createState() => CamelotState();
}

class CamelotState extends State<Camelot> {

  static CamelotState? of(BuildContext context) {
    final CamelotState? result = context.findAncestorStateOfType<
        CamelotState>();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}


