import 'package:flutter/widgets.dart';

import 'style/internal_style_config.dart';

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

  /// Hook for internal tab styles.
  StyleHook provideStyle() {
    return InternalStyle();
  }
}

/// Default tab styles are configured with internal layout/size, these are not
/// exposed like color or height information. You can use [ConvexAppBar.builder]
/// to fully customize the tab widget.
///
/// However, if you just want to override some of the internal config and willing
/// to take risk of the modified effects, try with the config carefully.
abstract class StyleHook {
  /// size of icon
  double get iconSize;

  /// margin outside of icon
  double get activeIconMargin;

  /// size of convex icon
  double get activeIconSize;

  /// style for text label.
  ///
  /// Warning:
  /// Override the text size can lead to `layout overflow` warning, you may need
  /// to update the height of bar too.
  TextStyle textStyle(Color color);

}
