import 'package:flutter/material.dart';
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

  final Widget child;

  final bool enableLogPanel;

  final double logPanelHeight;

  @override
  ConsumerState createState() => CamelotState();
}

class CamelotState extends ConsumerState<Camelot> {
  static CamelotState? of(BuildContext context) {
    final CamelotState? result =
        context.findAncestorStateOfType<CamelotState>();
    return result;
  }

  late ScrollController scrollController;
  bool firstAutoscrollExecuted = false;
  bool shouldAutoscroll = false;

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

  @override
  Widget build(BuildContext context) {
    final isOpen = ref.watch(camelotLogPanelProvider);
    final logs = ref.watch(camelotLogsProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollToBottom();
        // scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });

    return Stack(
      children: [
        widget.child,
        if (widget.enableLogPanel)
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
                        ref.read(camelotLogPanelProvider.notifier).state = true;
                      },
                    ),
            ),
          ),
        if (widget.enableLogPanel)
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
                      height: widget.logPanelHeight,
                      padding: const EdgeInsets.all(8),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white70.withAlpha(230),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, -1),
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
                              IconButton(
                                tooltip: 'CLEAR LOG',
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                iconSize: 20,
                                constraints: BoxConstraints.tight(
                                  const Size(32, 32),
                                ),
                                icon: const Icon(
                                  Icons.delete_outline,
                                ),
                                onPressed: () {
                                  CLog.clear();
                                },
                              ),
                              const SizedBox(width: 10),
                              IconButton(
                                tooltip: 'CLOSE PANEL',
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                iconSize: 20,
                                constraints: BoxConstraints.tight(
                                  const Size(32, 32),
                                ),
                                icon: const Icon(
                                  Icons.close_outlined,
                                ),
                                onPressed: () {
                                  ref
                                      .read(camelotLogPanelProvider.notifier)
                                      .state = false;
                                },
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: logs.value?.length ?? 0,
                              itemBuilder: (context, index) {
                                final log = logs.value![index];

                                return Text(
                                  '$log',
                                  style: TextStyle(color: log.level.color),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : const SizedBox.square(),
          ),
      ],
    );
  }
}
