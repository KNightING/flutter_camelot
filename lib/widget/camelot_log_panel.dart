import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camelot/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../log/camelot_log.dart';
import '../log/camelot_log_provider.dart';
import 'camelot_icon_button.dart';

class CamelotLogPanel extends StatefulWidget {
  const CamelotLogPanel({
    Key? key,
    required this.builder,
    this.enableLogPanel = true,
    this.logPanelHeight = 400,
    this.whenTapClearFocus = true,
  }) : super(key: key);

  factory CamelotLogPanel.child({
    Key? key,
    required Widget child,
    bool enableLogPanel = true,
    double logPanelHeight = 400,
    bool whenTapClearFocus = true,
  }) {
    return CamelotLogPanel(
      key: key,
      enableLogPanel: enableLogPanel,
      logPanelHeight: logPanelHeight,
      whenTapClearFocus: whenTapClearFocus,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  final bool enableLogPanel;

  final double logPanelHeight;

  final WidgetBuilder builder;

  final bool whenTapClearFocus;

  @override
  State createState() => CamelotLogPanelState();
}

class CamelotLogPanelState extends State<CamelotLogPanel> {
  static CamelotLogPanelState? of(BuildContext context) {
    final CamelotLogPanelState? result =
        context.findAncestorStateOfType<CamelotLogPanelState>();
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
            Builder(builder: widget.builder),
            _CamelotLogPanel(
              enable: widget.enableLogPanel,
              height: widget.logPanelHeight,
            ),
          ],
        ),
      ),
    );
  }
}

class _CamelotLogPanel extends ConsumerStatefulWidget {
  const _CamelotLogPanel({
    Key? key,
    this.enable = true,
    this.height = 400,
  }) : super(key: key);

  final bool enable;

  final double height;

  @override
  ConsumerState createState() => _CamelotLogPanelState();
}

class _CamelotLogPanelState extends ConsumerState<_CamelotLogPanel> {
  late ScrollController scrollController;

  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  bool get enable => widget.enable;

  @override
  Widget build(BuildContext context) {
    final isOpen = ref.watch(camelotLogPanelProvider);
    final logs = ref.watch(camelotLogsProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollToBottom();
      }
    });

    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          if (enable)
            Positioned(
              bottom: 25,
              right: 25,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: isOpen
                    ? const SizedBox.square()
                    : FloatingActionButton(
                        child: const Icon(
                          Icons.bug_report,
                        ),
                        onPressed: () {
                          ref.read(camelotLogPanelProvider.notifier).state =
                              true;
                        },
                      ),
              ),
            ),
          if (enable)
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween = Tween<Offset>(
                    begin: const Offset(0, 1), end: const Offset(0, 0));
                return SlideTransition(
                  position: tween.animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: isOpen
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: widget.height,
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: Colors.black87,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              offset: Offset(0, -1),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'CAMELOT LOG PANEL',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade400,
                                  ),
                                ),
                                const Spacer(),
                                CamelotIconButton(
                                  Icons.delete_outline,
                                  tooltip: 'CLEAR LOG',
                                  iconSize: 20,
                                  size: 32,
                                  onPressed: () {
                                    CLog.clear();
                                  },
                                ),
                                const SizedBox(width: 10),
                                CamelotIconButton(
                                  Icons.close_outlined,
                                  tooltip: 'CLOSE PANEL',
                                  iconSize: 20,
                                  size: 32,
                                  onPressed: () {
                                    ref
                                        .read(camelotLogPanelProvider.notifier)
                                        .state = false;
                                  },
                                ),
                              ],
                            ),
                            Divider(color: Colors.grey.shade400),
                            Expanded(
                              child: SelectionArea(
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: logs.value?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final log = logs.value![index];

                                    return Text(
                                      '$log',
                                      key: ValueKey(log.timestamp),
                                      style: TextStyle(color: log.level.color),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.square(),
            ),
        ],
      ),
    );
  }
}
