/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import 'package:convex_bottom_bar/src/item.dart';
import 'package:convex_bottom_bar/src/style/blend_image_icon.dart';
import 'package:convex_bottom_bar/src/style/inner_builder.dart';
import 'package:convex_bottom_bar/src/style/transition_container.dart';
import 'package:flutter/material.dart';

/// Tab icon, text animated with pop transition.
class TitledTabStyle extends InnerBuilder {
  /// Create style builder.
  TitledTabStyle({
    required List<TabItem<dynamic>> items,
    required Color activeColor,
    required Color color,
    required this.curve,
    required this.backgroundColor,
  }) : super(items: items, activeColor: activeColor, color: color);

  /// Curve for tab transition.
  final Curve curve;

  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Previous active tab index.
  int _preActivate = -1;

  @override
  Widget build(BuildContext context, int index, bool active) {
    final pre = _preActivate;
    if (active) {
      _preActivate = index;
    }
    final item = items[index];
    final style = ofStyle(context);
    final margin = style.activeIconMargin;

    if (active) {
      return TransitionContainer.slide(
        data: index,
        duration: const Duration(milliseconds: 200),
        curve: curve,
        child: Container(
          // necessary otherwise the badge will not large enough
          width: style.layoutSize,
          height: style.layoutSize,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(shape: BoxShape.circle, color: activeColor),
          child: BlendImageIcon(
            item.activeIcon ?? item.icon,
            size: style.activeIconSize,
            color: item.blend ? backgroundColor : null,
          ),
        ),
      );
    }

    final textStyle = style.textStyle(activeColor, item.fontFamily);
    if (pre == index) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(item.title ?? '', style: textStyle),
          TransitionContainer.slide(
            reverse: true,
            curve: curve,
            child: Container(
              margin: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: activeColor,
              ),
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                size: style.activeIconSize,
                color: item.blend ? backgroundColor : null,
              ),
            ),
          )
        ],
      );
    }
    return Center(child: Text(item.title ?? '', style: textStyle));
  }
}
