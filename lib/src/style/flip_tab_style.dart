import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'transition_container.dart';

/// Convex shape is moved after selection
class FlipTabStyle extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;
  final Curve curve;

  FlipTabStyle({this.items, this.activeColor, this.color, this.curve});

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    if (active) {
      return TransitionContainer.flip(
        duration: Duration(milliseconds: 500),
        height: ACTION_LAYOUT_SIZE,
        bottomChild: Container(
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
        ),
        topChild: Container(
          height: BAR_HEIGHT,
          color: Colors.transparent,
          child: Center(
            child: BlendImageIcon(item.icon, color: item.blend ? color : null),
          ),
        ),
        curve: curve,
      );
    }
    return Container(
      height: BAR_HEIGHT,
      color: Colors.transparent,
      child: Center(
        child: BlendImageIcon(item.icon, color: item.blend ? color : null),
      ),
    );
  }
}
