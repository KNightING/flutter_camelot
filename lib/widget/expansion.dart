import 'package:flutter/material.dart';

class Expansion extends StatelessWidget {
  const Expansion({
    Key? key,
    required this.isExpand,
    required this.child,
    this.collapseChild,
  }) : super(key: key);

  final bool isExpand;

  final Widget? collapseChild;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: isExpand
          ? const Duration(milliseconds: 400)
          : const Duration(milliseconds: 600),
      curve: Curves.fastOutSlowIn,
      child: Container(
        child: isExpand ? child : collapseChild,
      ),
    );
  }
}
