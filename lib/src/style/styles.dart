import 'package:convex_bottom_bar/src/style/react_tab_style.dart';
import 'package:flutter/cupertino.dart';

import '../../convex_bottom_bar.dart';
import 'fixed_circle_tab_style.dart';
import 'fixed_tab_style.dart';
import 'react_circle_tab_style.dart';

DelegateBuilder supportedStyle(TabStyle style,
    {List<TabItem> items,
    Color color,
    Color activeColor,
    Color backgroundColor,
    Curve curve}) {
  DelegateBuilder builder;
  switch (style) {
    case TabStyle.fixed:
      builder = FixedTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        convexIndex: items.length ~/ 2,
      );
      break;
    case TabStyle.fixedCircle:
      builder = FixedCircleTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        backgroundColor: backgroundColor,
        convexIndex: items.length ~/ 2,
      );
      break;
    case TabStyle.react:
      builder = ReactTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        curve: curve,
      );
      break;
    case TabStyle.reactCircle:
      builder = ReactCircleTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        backgroundColor: backgroundColor,
        curve: curve,
      );
      break;
    case TabStyle.custom:
    // TODO: Handle this case.
//      break;
    default:
      builder = FixedTabStyle(
        items: items,
        color: color,
        activeColor: activeColor,
        convexIndex: items.length ~/ 2,
      );
      break;
  }
  return builder;
}
