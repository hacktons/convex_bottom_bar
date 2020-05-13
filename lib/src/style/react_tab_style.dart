import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';
import 'transition_container.dart';

/// Convex shape is moved after selection.
class ReactTabStyle extends InnerBuilder {
  /// Curve for tab transition.
  final Curve curve;

  /// Create style builder.
  ReactTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var item = items[index];
    var style = ofStyle(context);
    if (active) {
      return Container(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TransitionContainer.scale(
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: style.activeIconSize,
              ),
              curve: curve,
            ),
            Text(item.title, style: style.textStyle(activeColor))
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BlendImageIcon(item.icon, color: item.blend ? color : null),
          Text(item.title, style: style.textStyle(color))
        ],
      ),
    );
  }
}
