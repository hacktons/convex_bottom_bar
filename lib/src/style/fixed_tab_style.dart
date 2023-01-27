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
import 'package:flutter/material.dart';

/// Convex shape is fixed center.
class FixedTabStyle extends InnerBuilder {
  /// Create style builder.
  FixedTabStyle({
    required List<TabItem<dynamic>> items,
    required Color activeColor,
    required Color color,
    required this.convexIndex,
  }) : super(items: items, activeColor: activeColor, color: color);

  /// Index of the centered convex shape.
  final int convexIndex;

  @override
  Widget build(BuildContext context, int index, bool active) {
    final c = active ? activeColor : color;
    final style = ofStyle(context);
    final item = items[index];
    final textStyle = style.textStyle(c, item.fontFamily);

    if (index == convexIndex) {
      final item = items[convexIndex];
      return Container(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlendImageIcon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: item.blend ? c : null,
              size: style.activeIconSize,
            ),
            Text(item.title ?? '', style: textStyle)
          ],
        ),
      );
    }

    final noLabel = style.hideEmptyLabel && hasNoText(item);
    final icon = BlendImageIcon(
      active ? item.activeIcon ?? item.icon : item.icon,
      size: style.iconSize,
      color: item.blend ? c : null,
    );
    final children = noLabel
        ? <Widget>[icon]
        : <Widget>[icon, Text(item.title ?? '', style: textStyle)];
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: children,
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}
