import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CamelotLogPanel extends ConsumerWidget {
  const CamelotLogPanel({
    super.key,
    required this.child,
    this.enable = true,
    this.alignment = Alignment.centerRight,
  }) : super();

  final Widget child;

  final bool enable;

  final Alignment alignment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        child,
        AnimatedSwitcher(
          key: ValueKey(enable),
          duration: const Duration(milliseconds: 250),
          child: enable
              ? Align(
                  alignment: alignment,
                  child: Container(
                    height: double.infinity,
                    width: 100,
                    color: Colors.redAccent,
                  ),
                )
              : const SizedBox.square(),
        )
      ],
    );
  }
}
