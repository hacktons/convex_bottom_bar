import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class ChipBuilder {
  Widget build(BuildContext context, Widget child, int index, bool active);
}

/// Simple badge with num inside
class DefaultChipBuilder extends ChipBuilder {
  final Map<int, dynamic> chips;
  final Color textColor;
  final Color badgeColor;
  final EdgeInsets padding;
  final double borderRadius;

  DefaultChipBuilder(
    this.chips, {
    this.textColor,
    this.badgeColor,
    this.padding,
    this.borderRadius,
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

  Widget asBadge(dynamic chip) {
    if (chip is String) {
      return Positioned.fill(
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
              style: TextStyle(color: textColor ?? Colors.white, fontSize: 12),
            ),
          ),
        ),
      );
    } else if (chip is IconData) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            padding: padding ?? EdgeInsets.only(left: 4, right: 4),
            child: Icon(chip, color: badgeColor ?? Colors.redAccent, size: 14),
          ),
        ),
      );
    } else if (chip is Widget) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            padding: padding ?? EdgeInsets.only(left: 4, right: 4),
            child: chip,
          ),
        ),
      );
    } else if (chip is Color) {
      return Positioned.fill(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            margin: EdgeInsets.only(top: 10, right: 10),
            padding: padding ?? EdgeInsets.only(left: 4, right: 4),
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: badgeColor ?? Colors.redAccent),
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
