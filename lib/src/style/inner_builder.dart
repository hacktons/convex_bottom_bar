import 'dart:ui';

import '../interface.dart';
import '../item.dart';

/// Simple builder which extend [DelegateBuilder] to provide some necessary config.
abstract class InnerBuilder extends DelegateBuilder {
  /// List of [TabItem] stands for tabs.
  final List<TabItem> items;

  /// Color used when tab is active.
  final Color activeColor;

  /// Color used for tab.
  final Color color;

  /// Create style builder.
  InnerBuilder({this.items, this.activeColor, this.color});
}
