import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camelot/extension/kotlin_like_extension.dart';
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

  late FocusNode _scapegoatFocusNode;

  @override
  void initState() {
    super.initState();
    _scapegoatFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _scapegoatFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (widget.whenTapClearFocus || Platform.isWindows) {
            final currentFocus = FocusScope.of(context).focusedChild;
            if (currentFocus != null && currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
              _scapegoatFocusNode.requestFocus();
            }
          }
        },
        child: Stack(
          children: [
            SizedBox(
              width: 0.01,
              height: 0.01,
              child: FilledButton(
                focusNode: _scapegoatFocusNode,
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                ),
                autofocus: true,
                onPressed: () {},
                child: null,
              ),
            ),
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
