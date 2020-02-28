import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Tab icon, text animated with pop transition.
class TitledTabStyle extends InnerBuilder {
  /// Curve for tab transition.
  final Curve curve;

  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Previous active tab index.
  int preActivate = -1;

  /// Margin of tab.
  final margin = (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 4;

  /// Create style builder.
  TitledTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.curve,
    this.backgroundColor,
  }) : super(items: items, activeColor: activeColor, color: color);

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
