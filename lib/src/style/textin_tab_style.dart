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
class TextInTabStyle extends InnerBuilder {
  /// Create style builder.
  TextInTabStyle({
    required List<TabItem<dynamic>> items,
    required Color activeColor,
    required Color color,
    required this.curve,
  }) : super(items: items, activeColor: activeColor, color: color);

  /// Curve for tab transition.
  final Curve curve;

  @override
  Widget build(BuildContext context, int index, bool active) {
    final item = items[index];
    final style = ofStyle(context);
    if (active) {
      final textStyle = style.textStyle(activeColor, item.fontFamily);
      return Container(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TransitionContainer.scale(
              data: index,
              curve: curve,
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: style.activeIconSize,
              ),
            ),
            TransitionContainer.slide(
              curve: curve,
              child: Text(item.title ?? '', style: textStyle),
            ),
          ],
        ),
      );
    }

    return Center(
      child: BlendImageIcon(
        item.icon,
        size: style.iconSize,
        color: item.blend ? color : null,
      ),
    );
  }
}
