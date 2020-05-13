import 'dart:ui';

import 'package:flutter/cupertino.dart';

import '../bar.dart';
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

  /// Style hook to override the internal tab style
  StyleHook _style;

  /// Create style builder.
  InnerBuilder({this.items, this.activeColor, this.color});

  StyleHook ofStyle(BuildContext context) {
    return StyleProvider.of(context)?.style ?? (_style ??= provideStyle());
  }
}
