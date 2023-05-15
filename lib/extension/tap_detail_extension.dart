import 'package:flutter/widgets.dart';

extension _GlobalPosition on Offset {
  Alignment globalToAlignment(BuildContext context) {
    var alignX = 0.0;
    var alignY = 0.0;

    final physicalSize = View.of(context).physicalSize;
    final windowWidthHalf = physicalSize.width / 2;
    final windowHeightHalf = physicalSize.height / 2;

    if (dx > windowWidthHalf) {
      alignX = (dx - windowWidthHalf) / windowWidthHalf;
    } else if (dx < windowWidthHalf) {
      alignX = dx / windowWidthHalf - 1;
    }

    if (dy > windowHeightHalf) {
      alignY = (dy - windowHeightHalf) / windowHeightHalf;
    } else if (dy < windowHeightHalf) {
      alignY = dy / windowHeightHalf - 1;
    }
    return Alignment(alignX, alignY);
  }
}

extension TapDownDetailExtension on TapDownDetails {
  Alignment globalToAlignment(BuildContext context) {
    return globalPosition.globalToAlignment(context);
  }
}

extension TapUpDetailExtension on TapUpDetails {
  Alignment globalToAlignment(BuildContext context) {
    return globalPosition.globalToAlignment(context);
  }
}
