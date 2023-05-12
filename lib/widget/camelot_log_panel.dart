import 'package:flutter/material.dart';
import 'package:flutter_camelot/extension/context_extension.dart';
import 'package:flutter_camelot/widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../log/camelot_log.dart';
import '../log/camelot_log_provider.dart';

class CamelotLogPanel extends ConsumerStatefulWidget {
  const CamelotLogPanel({
    Key? key,
    this.enable = true,
    this.height = 400,
  }) : super(key: key);

  final bool enable;

  final double height;

  @override
  ConsumerState createState() => _CamelotLogPanelState();
}

class _CamelotLogPanelState extends ConsumerState<CamelotLogPanel> {
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
    final (theme, cs, tt) = context.t;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollToBottom();
        // scrollController.jumpTo(scrollController.position.maxScrollExtent);
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
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          color: cs.background.withAlpha(230),
                          boxShadow: [
                            BoxShadow(
                              color: theme.brightness == Brightness.light
                                  ? Colors.black26
                                  : Colors.black54,
                              offset: const Offset(0, -1),
                              blurRadius: 5,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'CAMELOT LOG PANEL',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
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
                            Divider(color: cs.onBackground),
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
