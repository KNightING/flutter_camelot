import 'package:flutter/material.dart';
import 'package:flutter_camelot/widget/camelot_log_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Camelot extends ConsumerStatefulWidget {
  const Camelot({
    Key? key,
    required this.child,
    this.enableLogPanel = true,
    this.logPanelHeight = 400,
    this.whenTapClearFocus = true,
  }) : super(key: key);

  final bool enableLogPanel;

  final double logPanelHeight;

  final Widget child;

  final bool whenTapClearFocus;

  @override
  ConsumerState createState() => CamelotState();
}

class CamelotState extends ConsumerState<Camelot> {
  static CamelotState? of(BuildContext context) {
    final CamelotState? result =
        context.findAncestorStateOfType<CamelotState>();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (widget.whenTapClearFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Stack(
          children: [
            widget.child,
            CamelotLogPanel(
              enable: widget.enableLogPanel,
              height: widget.logPanelHeight,
            ),
          ],
        ),
      ),
    );
  }
}
