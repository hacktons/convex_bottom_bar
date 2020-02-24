import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center with circle.
class FixedCircleTabStyle extends InnerBuilder {
  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Index of the centered convex shape.
  final int convexIndex;

  /// Margin of tab.
  final margin = (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 4;

  FixedCircleTabStyle(
      {List<TabItem> items,
      Color activeColor,
      Color color,
      this.backgroundColor,
      this.convexIndex})
      : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    if (index == convexIndex) {
      final item = items[index];
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? activeColor : color,
        ),
        width: ACTION_LAYOUT_SIZE,
        height: ACTION_LAYOUT_SIZE,
        margin: EdgeInsets.all(margin),
        child: BlendImageIcon(
          active ? item.activeIcon ?? item.icon : item.icon,
          size: ACTION_INNER_BUTTON_SIZE,
          color: item.blend ? backgroundColor : null,
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
