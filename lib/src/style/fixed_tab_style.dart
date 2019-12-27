import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';

/// Convex tab is fixed center
class FixedTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final int convexIndex;
  DelegateBuilder tabBuilder;
  DelegateBuilder convexBuilder;

  FixedTabStyle({this.items, this.activeColor, this.color, this.convexIndex});

  @override
  Widget build(BuildContext context, int index, bool active) {
    if (index == convexIndex) {
      var item = items[convexIndex];
      return Container(
        height: ACTION_LAYOUT_SIZE,
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: active ? activeColor : color,
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
    var navigationItem = items[index];
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
              active
                  ? navigationItem.activeIcon ?? navigationItem.icon
                  : navigationItem.icon,
              color: active ? activeColor : color),
          Text(
            navigationItem.title,
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
