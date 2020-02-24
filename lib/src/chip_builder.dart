import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Interface to apply any custom badge chip
abstract class ChipBuilder {
  /// Construct a new widget which represent the tab item with custom badge.
  ///
  /// * [context] BuildContext instance
  /// * [child] the tab item Widget
  /// * [index] index of the tab item
  /// * [active] active state for the index
  Widget build(BuildContext context, Widget child, int index, bool active);
}

/// Simple badge with num inside
class DefaultChipBuilder extends ChipBuilder {
  /// key-value map, stands for the badge data
  final Map<int, dynamic> chips;

  /// Color of badge text
  final Color textColor;

  /// Color of the badge chip
  final Color badgeColor;

  /// Padding for badge
  final EdgeInsets padding;

  /// Radius corner for badge
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

  /// factory method which convert a chip data into [Widget];
  ///
  /// * [chip] String, return a [Text] badge;
  /// * [chip] IconData, return a [Icon] badge;
  /// * [chip] Widget, return a [Widget] badge;
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
