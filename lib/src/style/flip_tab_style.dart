import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Tab item are flipped when click.
class FlipTabStyle extends InnerBuilder {
  /// Curve for flip transition.
  final Curve curve;

  /// Create style builder.
  FlipTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

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
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: ACTION_INNER_BUTTON_SIZE,
              ),
              Text(item.title, style: TextStyle(color: activeColor))
            ],
          ),
        ),
        topChild: Container(
          height: BAR_HEIGHT,
          child: Center(
            child: BlendImageIcon(item.icon, color: item.blend ? color : null),
          ),
        ),
        curve: curve,
      );
    }
    return Center(
      child: BlendImageIcon(item.icon, color: item.blend ? color : null),
    );
  }
}
