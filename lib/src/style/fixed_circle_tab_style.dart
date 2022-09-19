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

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center with circle.
class FixedCircleTabStyle extends InnerBuilder {
  /// Color used as background of appbar and circle icon.
  final Color backgroundColor;

  /// Index of the centered convex shape.
  final int convexIndex;

  /// Create style builder
  FixedCircleTabStyle(
      {required List<TabItem> items,
      required Color activeColor,
      required Color color,
      required this.backgroundColor,
      required this.convexIndex})
      : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var c = active ? activeColor : color;
    var item = items[index];
    var style = ofStyle(context);
    var textStyle = style.textStyle(c, item.fontFamily);
    var margin = style.activeIconMargin;

    if (index == convexIndex) {
      final item = items[index];
      return Container(
        // necessary otherwise the badge will not large enough
        width: style.layoutSize,
        height: style.layoutSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: c,
        ),
        margin: EdgeInsets.all(margin),
        child: BlendImageIcon(
          active ? item.activeIcon ?? item.icon : item.icon,
          size: style.activeIconSize,
          color: item.blend ? backgroundColor : null,
        ),
      );
    }

    var noLabel = style.hideEmptyLabel && hasNoText(item);
    var icon = BlendImageIcon(
      active ? item.activeIcon ?? item.icon : item.icon,
      color: item.blend ? (c) : null,
      size: style.iconSize,
    );
    var children = noLabel
        ? <Widget>[icon]
        : <Widget>[icon, Text(item.title ?? '', style: textStyle)];
    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}
