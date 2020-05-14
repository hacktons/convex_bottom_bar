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
    var hasTitle = item.title != null && item.title.isNotEmpty;

    if (active) {
      return Container(
        padding: const EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment:
              hasTitle ? MainAxisAlignment.end : MainAxisAlignment.center,
          children: <Widget>[
            TransitionContainer.scale(
              child: BlendImageIcon(
                item.activeIcon ?? item.icon,
                color: item.blend ? activeColor : null,
                size: style.activeIconSize,
              ),
              curve: curve,
            ),
            style.hideEmptyLabel && !hasTitle
                ? null
                : Text(item.title, style: style.textStyle(activeColor))
          ]..removeWhere((it) => it == null),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment:
            hasTitle ? MainAxisAlignment.end : MainAxisAlignment.center,
        children: <Widget>[
          BlendImageIcon(item.icon, color: item.blend ? color : null),
          style.hideEmptyLabel && !hasTitle
              ? null
              : Text(item.title, style: style.textStyle(color))
        ]..removeWhere((it) => it == null),
      ),
    );
  }
}
