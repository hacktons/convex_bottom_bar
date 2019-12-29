import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';

/// Convex shape is moved after selection
class ReactTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;

  ReactTabStyle({this.items, this.activeColor, this.color});

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
      return Container(
        height: ACTION_LAYOUT_SIZE,
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              item.activeIcon ?? item.icon,
              color: activeColor,
              size: ACTION_INNER_BUTTON_SIZE,
            ),
            Text(item.title, style: TextStyle(color: activeColor))
          ],
        ),
      );
    }
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(item.icon, color: color),
          Text(item.title, style: TextStyle(color: color))
        ],
      ),
    );
  }
}
