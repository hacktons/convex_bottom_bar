import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Tab icon, text animated with pop transition.
class TextInTabStyle extends InnerBuilder {
  /// Curve for tab transition.
  final Curve curve;

  /// Create style builder.
  TextInTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
      return Container(
        height: ACTION_LAYOUT_SIZE,
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TransitionContainer.scale(
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: ACTION_INNER_BUTTON_SIZE,
              ),
              curve: curve,
            ),
            TransitionContainer.slide(
              child: Text(item.title, style: TextStyle(color: activeColor)),
              curve: curve,
            ),
          ],
        ),
      );
    }

    return Center(
      child: BlendImageIcon(item.icon, color: item.blend ? color : null),
    );
  }
}
