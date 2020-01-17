import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';

/// Convex shape is fixed center with circle
class FixedCircleTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Color backgroundColor;
  final int convexIndex;

  FixedCircleTabStyle(
      {this.items,
      this.activeColor,
      this.color,
      this.backgroundColor,
      this.convexIndex});

  @override
  Widget build(BuildContext context, int index, bool active) {
    if (index == convexIndex) {
      final item = items[index];
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          SizedBox(
            width: ACTION_LAYOUT_SIZE,
            height: ACTION_LAYOUT_SIZE,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? activeColor : color,
              ),
              padding: EdgeInsets.all(
                  (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 2),
              child: BlendImageIcon(
                active ? item.activeIcon ?? item.icon : item.icon,
                size: ACTION_INNER_BUTTON_SIZE,
                color: item.blend ? backgroundColor : null,
              ),
            ),
          )
        ],
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
