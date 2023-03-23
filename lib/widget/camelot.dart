import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camelot/widget/camelot_log_panel.dart';

class Camelot extends StatefulWidget {
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
  State createState() => CamelotState();
}

class CamelotState extends State<Camelot> {
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
            final currentFocus = FocusScope.of(context);
            if (currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
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
