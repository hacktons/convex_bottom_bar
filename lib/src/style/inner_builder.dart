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

import 'package:flutter/cupertino.dart';

import '../bar.dart';
import '../interface.dart';
import '../item.dart';
import 'internal_style_config.dart';

/// Simple builder which extend [DelegateBuilder] to provide some necessary config.
abstract class InnerBuilder extends DelegateBuilder {
  /// List of [TabItem] stands for tabs.
  final List<TabItem> items;

  /// Color used when tab is active.
  final Color activeColor;

  /// Color used for tab.
  final Color color;

  /// Style hook to override the internal tab style
  StyleHook? _style;

  /// Create style builder.
  InnerBuilder(
      {required this.items, required this.activeColor, required this.color});

  /// Get style config
  StyleHook ofStyle(BuildContext context) {
    return StyleProvider.of(context)?.style ?? (_style ??= InternalStyle());
  }

  /// Return true if title text exists
  bool hasNoText(TabItem item) {
    return item.title == null || item.title!.isEmpty;
  }
}
