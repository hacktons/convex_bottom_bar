/*
 *  Copyright 2020 chaobinwu89@gmail.com
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

import 'dart:ui';

import 'package:flutter/material.dart';

import '../item.dart';
import 'blend_image_icon.dart';
import 'inner_builder.dart';

/// Convex shape is fixed center.
class FixedTabStyle extends InnerBuilder {
  /// Index of the centered convex shape.
  final int convexIndex;

  /// Create style builder.
  FixedTabStyle({
    List<TabItem> items,
    Color activeColor,
    Color color,
    this.convexIndex,
  }) : super(items: items, activeColor: activeColor, color: color);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var c = active ? activeColor : color;
    var style = ofStyle(context);
    var textStyle = style.textStyle(c);
    var item = items[index];

    if (index == convexIndex) {
      var item = items[convexIndex];
      return Container(
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BlendImageIcon(
              active ? item.activeIcon ?? item.icon : item.icon,
              color: item.blend ? (c) : null,
              size: style.activeIconSize,
            ),
            Text(item.title, style: textStyle)
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          BlendImageIcon(
            active ? item.activeIcon ?? item.icon : item.icon,
            size: style.iconSize,
            color: item.blend ? (c) : null,
          ),
          style.hideEmptyLabel && (item.title == null || item.title.isEmpty)
              ? null
              : Text(item.title ?? '', style: textStyle)
        ]..removeWhere((it) => it == null),
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}
