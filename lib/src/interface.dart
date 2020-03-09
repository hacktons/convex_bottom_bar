import 'package:flutter/widgets.dart';

/// Tab callback, [index] are tab index which is being clicked.
typedef GestureTapIndexCallback = void Function(int index);

/// Tab builder.
/// * [context] BuildContent instance
/// * [index] index of tab
/// * [active] active state for tab index
typedef CustomTabBuilder = Widget Function(
    BuildContext context, int index, bool active);

/// Interface to apply any custom badge chip.
abstract class ChipBuilder {
  /// Construct a new widget which represent the tab item with custom badge.
  ///
  /// * [context] BuildContext instance;
  /// * [child] the tab item Widget;
  /// * [index] index of the tab item;
  /// * [active] active state for the index;
  Widget build(BuildContext context, Widget child, int index, bool active);
}

/// Item builder.
abstract class DelegateBuilder {
  /// Called when the tab item is build.
  /// * [context] BuildContext instance;
  /// * [index] tab index;
  /// * [active] tab state;
  Widget build(BuildContext context, int index, bool active);

  /// Whether the convex shape is fixed center or positioned according to selection.
  bool fixed() {
    return false;
  }
}
