import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center.
class FixedTabStyle extends InnerBuilder {
  /// Index of the centered convex shape.
  final int convexIndex;

  /// Create style builder.
  FixedTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.convexIndex,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    if (index == convexIndex) {
      var item = items[convexIndex];
      return Container(
        height: ACTION_LAYOUT_SIZE,
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlendImageIcon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: item.blend ? (active ? activeColor : color) : null,
              size: ACTION_INNER_BUTTON_SIZE,
            ),
            Text(
              item.title,
              style: TextStyle(color: active ? activeColor : color),
            )
          ],
        ),
      );
    }
    var item = items[index];
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            color: item.blend ? (active ? activeColor : color) : null,
          ),
          Text(
            item.title,
            style: TextStyle(color: active ? activeColor : color),
          )
        ],
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}
