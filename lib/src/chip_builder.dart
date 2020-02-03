import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ChipBuilder {
  Widget build(BuildContext context, Widget child, int index, bool active);
}

/// Simple badge with num inside
class DefaultChipBuilder extends ChipBuilder {
  final Map<int, String> chips;
  final Color badgeColor;
  final EdgeInsets padding;
  final double borderRadius;

  DefaultChipBuilder(
    this.chips, {
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
        Padding(
          padding: EdgeInsets.only(left: 20, bottom: 20),
          child: Material(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20)),
            type: MaterialType.card,
            color: badgeColor ?? Colors.redAccent,
            child: Padding(
              child: Text(chip, style: TextStyle(color: Colors.white, fontSize: 12)),
              padding: padding ?? EdgeInsets.only(left: 4, right: 4),
            ),
          ),
        ),
      ],
    );
  }
}
