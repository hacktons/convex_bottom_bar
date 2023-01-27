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

import 'package:convex_bottom_bar/src/painter.dart';
import 'package:flutter/material.dart';

/// Single convex button widget
class ConvexButton extends StatelessWidget {
  /// Make new instance of [ConvexButton]
  const ConvexButton({
    Key? key,
    this.size,
    this.sigma,
    required this.child,
    this.thickness,
    this.backgroundColor,
    this.top,
  }) : super(key: key);

  /// Make a centered convex button.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-single-shape.png)
  factory ConvexButton.fab({
    Key? key,
    double? size,
    double? thickness,
    double? top,
    double? sigma,
    double iconSize = 32,
    double border = 2,
    Color color = Colors.redAccent,
    IconData icon = Icons.keyboard_voice,
    Color? backgroundColor,
    VoidCallback? onTap,
  }) {
    thickness = thickness ?? _DEFAULT_THICKNESS;
    final fab = Container(
      margin: EdgeInsets.only(bottom: thickness),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: border),
      ),
      child: Icon(icon, color: color, size: iconSize),
    );
    return ConvexButton(
      key: key,
      size: size,
      thickness: thickness,
      top: top,
      backgroundColor: backgroundColor,
      sigma: sigma,
      child: GestureDetector(onTap: onTap, child: fab),
    );
  }
  static const _DEFAULT_SIZE = 60.0;
  static const _DEFAULT_TOP = 50.0;
  static const _DEFAULT_SIGMA = 2.0;
  static const _DEFAULT_THICKNESS = 4.0;

  /// Size of convex shape, should be lager than [top]
  final double? size;

  /// The distance to edge from the bottom of child widget.
  final double? top;

  /// Height of bottom border
  final double? thickness;

  /// Sigma for border
  final double? sigma;

  /// Optional child widget, default to be a widget of Icons.keyboard_voice
  final Widget child;

  /// Color for the button
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
      SizedBox(
        height: thickness ?? _DEFAULT_THICKNESS,
        width: double.infinity,
        child: CustomPaint(
          painter: ConvexPainter(
            top: -(top ?? _DEFAULT_TOP),
            width: size ?? _DEFAULT_SIZE,
            height: size ?? _DEFAULT_SIZE,
            color: backgroundColor ?? Colors.grey[50]!,
            sigma: sigma ?? _DEFAULT_SIGMA,
          ),
        ),
      ),
      child,
    ],);
  }
}
