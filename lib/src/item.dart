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

/// Tab item used for [ConvexAppBar].
class TabItem<T> {
  // this code is added by moein
  final String? fontFamily;

  /// Tab text.
  final String? title;

  /// IconData or Image.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-image.gif)
  final T icon;

  /// Optional if not provided ,[icon] is used.
  final T? activeIcon;

  /// Whether icon should blend with color.
  /// If [icon] is instance of [IconData] then blend is default to true, otherwise false
  final bool blend;

  /// Create item
  const TabItem({
    this.fontFamily,
    this.title = '',
    required this.icon,
    this.activeIcon,
    bool? isIconBlend,
  })  : assert(icon is IconData || icon is Widget,
            'TabItem only support IconData and Widget'),
        blend = isIconBlend ?? (icon is IconData);
}
