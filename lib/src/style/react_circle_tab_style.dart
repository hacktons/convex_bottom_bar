import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Convex shape is moved after selection.
class ReactCircleTabStyle extends InnerBuilder {
  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Curve for tab transition.
  final Curve curve;

  /// Margin of tab.
  final margin = (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 4;

  /// Create style builder.
  ReactCircleTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.backgroundColor,
    this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
      final item = items[index];
      return TransitionContainer.scale(
        child: Container(
          width: ACTION_LAYOUT_SIZE,
          height: ACTION_LAYOUT_SIZE,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? activeColor : color,
          ),
          child: BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            size: ACTION_INNER_BUTTON_SIZE,
            color: item.blend ? backgroundColor : null,
          ),
        ),
        curve: curve,
      );
    }
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            color: item.blend ? color : null,
          ),
          Text(item.title, style: TextStyle(color: color))
        ],
      ),
    );
  }
}
