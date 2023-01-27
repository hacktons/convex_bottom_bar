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

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:convex_bottom_bar/src/item.dart';
import 'package:convex_bottom_bar/src/style/blend_image_icon.dart';
import 'package:convex_bottom_bar/src/style/inner_builder.dart';
import 'package:convex_bottom_bar/src/style/transition_container.dart';
import 'package:flutter/material.dart';

/// Convex shape is moved after selection.
class ReactCircleTabStyle extends InnerBuilder {
  /// Create style builder.
  ReactCircleTabStyle({
    required List<TabItem<dynamic>> items,
    required Color activeColor,
    required Color color,
    required this.backgroundColor,
    required this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Curve for tab transition.
  final Curve curve;

  @override
  Widget build(BuildContext context, int index, bool active) {
    final item = items[index];
    final style = ofStyle(context);
    final margin = style.activeIconMargin;
    if (active) {
      final item = items[index];
      return TransitionContainer.scale(
        data: index,
        curve: curve,
        child: Container(
          // necessary otherwise the badge will not large enough
          width: style.layoutSize,
          height: style.layoutSize,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? activeColor : color,
          ),
          child: BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            size: style.activeIconSize,
            color: item.blend ? backgroundColor : null,
          ),
        ),
      );
    }
    final textStyle = style.textStyle(color, item.fontFamily);
    final noLabel = style.hideEmptyLabel && hasNoText(item);
    final children = <Widget>[
      BlendImageIcon(
        active ? item.activeIcon ?? item.icon : item.icon,
        size: style.iconSize,
        color: item.blend ? color : null,
      ),
    ];
    if (!noLabel) {
      children.add(Text(item.title ?? '', style: textStyle));
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}
