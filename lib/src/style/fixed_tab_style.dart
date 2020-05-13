import 'dart:ui';

import 'package:flutter/material.dart';

import '../item.dart';
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
    var c = active ? activeColor : color;
    var style = ofStyle(context);
    var textStyle = style.textStyle(c);
    var item = items[index];

    if (index == convexIndex) {
      var item = items[convexIndex];
      return Container(
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlendImageIcon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: item.blend ? (c) : null,
              size: style.activeIconSize,
            ),
            Text(item.title, style: textStyle)
          ],
        ),
      );
    }
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            size: style.iconSize,
            color: item.blend ? (c) : null,
          ),
          Text(item.title, style: textStyle)
        ],
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}
