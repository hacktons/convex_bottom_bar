import 'package:flutter/material.dart';

class Badge {
  final Color color;
  final Color badgeColor;
  final EdgeInsets padding;
  final double borderRadius;
  final String text;

  const Badge(
    this.text, {
    this.color,
    this.badgeColor,
    this.padding,
    this.borderRadius,
  });
}
