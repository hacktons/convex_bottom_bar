import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ChipBuilder {
  Widget build(BuildContext context, Widget child, int index, bool active);
}

/// Simple badge with num inside
class DefaultChipBuilder extends ChipBuilder {
  final Map<int, String> chips;
  final Color color;
  final Color badgeColor;
  final EdgeInsets padding;
  final double borderRadius;

  DefaultChipBuilder(
    this.chips, {
    this.color,
    this.badgeColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(_, child, i, active) {
    var chip = chips[i];
    if (chip == null || chip.isEmpty) {
      return child;
    }
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        child,
        Positioned.fill(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(top: 10, right: 10),
              padding: padding ?? EdgeInsets.only(left: 4, right: 4),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: badgeColor ?? Colors.redAccent,
                borderRadius: BorderRadius.circular(borderRadius ?? 20),
              ),
              child: Text(
                chip,
                style: TextStyle(color: color ?? Colors.white, fontSize: 12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
