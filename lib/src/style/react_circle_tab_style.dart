import 'package:convex_bottom_bar/src/style/blend_image_icon.dart';
import 'package:convex_bottom_bar/src/style/scaled_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';

/// Convex shape is moved after selection
class ReactCircleTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Color backgroundColor;
  final Curve curve;

  ReactCircleTabStyle({
    this.items,
    this.activeColor,
    this.color,
    this.backgroundColor,
    this.curve,
  });

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
      final item = items[index];
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          ScaledContainer(
            child: Container(
              width: ACTION_LAYOUT_SIZE,
              height: ACTION_LAYOUT_SIZE,
              padding: EdgeInsets.all(
                  (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 2),
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
          ),
        ],
      );
    }
    return Container(
      color: Colors.transparent,
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
