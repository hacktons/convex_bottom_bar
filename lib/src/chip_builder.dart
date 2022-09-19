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
import 'package:flutter/widgets.dart';

import 'interface.dart';

/// Simple badge with num inside.
class DefaultChipBuilder extends ChipBuilder {
  /// key-value map, stands for the badge data.
  final Map<int, dynamic> chips;

  /// Color of badge text.
  final Color textColor;

  /// Color of the badge chip.
  final Color badgeColor;

  /// Padding for badge.
  final EdgeInsets padding;

  /// Margin for badge.
  final EdgeInsets margin;

  /// Radius corner for badge.
  final double borderRadius;

  /// Create a chip builder
  DefaultChipBuilder(
    this.chips, {
    required this.textColor,
    required this.badgeColor,
    required this.padding,
    required this.margin,
    required this.borderRadius,
  });

  @override
  Widget build(_, child, i, active) {
    var chip = chips[i];
    if (chip == null || chip == '') {
      return child;
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[child, asBadge(chip)],
    );
  }

  /// Convert a chip data into [Widget].
  ///
  /// * [chip] String, return a [Text] badge;
  /// * [chip] IconData, return a [Icon] badge;
  /// * [chip] Widget, return a [Widget] badge;
  Widget asBadge(dynamic chip) {
    if (chip is String) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: badgeColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Text(chip, style: TextStyle(color: textColor, fontSize: 12)),
          ),
        ),
      );
    } else if (chip is IconData) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: margin,
            padding: padding,
            child: Icon(chip, color: badgeColor, size: 14),
          ),
        ),
      );
    } else if (chip is Widget) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Container(margin: margin, padding: padding, child: chip),
        ),
      );
    } else if (chip is Color) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.center,
          child: Container(
            margin: margin,
            padding: padding,
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, color: chip),
              width: 10,
              height: 10,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
