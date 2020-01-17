import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'transition_container.dart';

/// tab icon, text animated with pop transition
class TitledTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Curve curve;
  final Color backgroundColor;
  int preActivate = -1;
  final margin = (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 2;

  TitledTabStyle({
    this.items,
    this.activeColor,
    this.color,
    this.curve,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, int index, bool active) {
    var pre = preActivate;
    if (active) {
      preActivate = index;
    }
    var item = items[index];
    if (active) {
      return TransitionContainer.slide(
        duration: Duration(milliseconds: 200),
        child: Container(
          width: ACTION_LAYOUT_SIZE,
          height: ACTION_LAYOUT_SIZE,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(shape: BoxShape.circle, color: activeColor),
          child: BlendImageIcon(
            item.activeIcon ?? item.icon,
            size: ACTION_INNER_BUTTON_SIZE,
            color: item.blend ? backgroundColor : null,
          ),
        ),
        curve: curve,
      );
    }

    if (pre == index) {
      return Stack(
        overflow: Overflow.visible,
        alignment: Alignment.center,
        children: <Widget>[
          Text(item.title, style: TextStyle(color: activeColor)),
          TransitionContainer.slide(
            reverse: true,
            child: Container(
              width: ACTION_LAYOUT_SIZE,
              height: ACTION_LAYOUT_SIZE,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor,
              ),
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                size: ACTION_INNER_BUTTON_SIZE,
                color: item.blend ? backgroundColor : null,
              ),
            ),
            curve: curve,
          )
        ],
      );
    }
    return Center(
      child: Text(item.title, style: TextStyle(color: activeColor)),
    );
  }
}
