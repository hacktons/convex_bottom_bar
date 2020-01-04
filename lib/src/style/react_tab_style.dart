import 'package:convex_bottom_bar/src/style/scaled_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';

/// Convex shape is moved after selection
class ReactTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Curve curve;

  ReactTabStyle({this.items, this.activeColor, this.color, this.curve});

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
            ScaledContainer(
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: ACTION_INNER_BUTTON_SIZE,
              ),
              curve: curve,
            ),
            Text(item.title, style: TextStyle(color: activeColor))
          ],
        ),
      );
    }
    return Container(
      height: BAR_HEIGHT,
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 2),
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
