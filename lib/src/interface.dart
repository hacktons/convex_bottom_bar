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

import 'package:flutter/widgets.dart';

/// Tab callback, [index] are tab index which is being clicked.
typedef GestureTapIndexCallback = void Function(int index);

/// Fire before [GestureTapIndexCallback] is handled, you may return false to block the tap event.
typedef TapNotifier = bool Function(int index);

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

/// Default tab styles are configured with internal layout/size, these are not
/// exposed like color or height information. You can use [ConvexAppBar.builder]
/// to fully customize the tab widget.
///
/// However, if you just want to override some of the internal config and willing
/// to take risk of the modified effects, try with the config carefully.
abstract class StyleHook {
  /// size of icon
  double? get iconSize;

  /// margin outside of icon
  double get activeIconMargin;

  /// size of convex icon
  double get activeIconSize;

  /// style for text label.
  ///
  /// Warning:
  /// Override the text size can lead to `layout overflow` warning, you may need
  /// to update the height of bar too.
  TextStyle textStyle(Color color, String? fontFamily);

  /// For styles with both ICON and label, omit the Text widget when label is null/empty
  bool get hideEmptyLabel {
    return true;
  }

  /// layout size are relative to icon size and margin
  double get layoutSize {
    return activeIconMargin * 4 + activeIconSize;
  }
}
