import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'transition_container.dart';
import 'blend_image_icon.dart';

/// tab icon, text animated with pop transition
class PopTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Curve curve;

  PopTabStyle({this.items, this.activeColor, this.color, this.curve});

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
      return Container(
        height: ACTION_LAYOUT_SIZE,
        color: Colors.transparent,
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

    return Container(
      height: BAR_HEIGHT,
      color: Colors.transparent,
      child: Center(
        child: BlendImageIcon(item.icon, color: item.blend ? color : null),
      ),
    );
  }
}
