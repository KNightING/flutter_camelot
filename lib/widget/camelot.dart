import 'package:flutter/material.dart';
import 'package:flutter_camelot/widget/camelot_log_panel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../log/camelot_log.dart';
import '../log/camelot_log_provider.dart';

class Camelot extends ConsumerStatefulWidget {
  const Camelot({
    Key? key,
    required this.child,
    this.enableLogPanel = true,
    this.logPanelHeight = 400,
  }) : super(key: key);

  final bool enableLogPanel;

  final double logPanelHeight;

  final Widget child;

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
      child: Stack(
        children: [
          widget.child,
          CamelotLogPanel(
            enable: widget.enableLogPanel,
            height: widget.logPanelHeight,
          ),
        ],
      ),
    );
  }
}
