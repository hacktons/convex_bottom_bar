import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';

/// Convex shape is moved after selection
class ReactCircleTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Color backgroundColor;

  ReactCircleTabStyle({
    this.items,
    this.activeColor,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
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
              child: Icon(
                item.icon,
                size: ACTION_INNER_BUTTON_SIZE,
                color: backgroundColor,
              ),
            ),
          )
        ],
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
