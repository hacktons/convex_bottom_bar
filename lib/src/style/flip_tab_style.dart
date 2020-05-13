import 'package:flutter/material.dart';

import '../item.dart';
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
    var style = ofStyle(context);
    var textStyle = style.textStyle(activeColor);

    if (active) {
      return TransitionContainer.flip(
        duration: Duration(milliseconds: 500),
        height: style.activeIconMargin + style.activeIconSize,
        bottomChild: Container(
          padding: EdgeInsets.only(bottom: 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: style.activeIconSize,
              ),
              Text(item.title, style: textStyle)
            ],
          ),
        ),
        topChild: Container(
          child: Center(
            child: BlendImageIcon(
              item.icon,
              color: item.blend ? color : null,
              size: style.iconSize,
            ),
          ),
        ),
        curve: curve,
      );
    }
    return Center(
      child: BlendImageIcon(
        item.icon,
        color: item.blend ? color : null,
        size: style.iconSize,
      ),
    );
  }
}
