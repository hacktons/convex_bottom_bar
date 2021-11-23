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

import 'package:flutter/material.dart';

import '../../convex_bottom_bar.dart';

/// Internal style configuration.
class InternalStyle extends StyleHook {
  @override
  double? get iconSize {
    // use null will fallback to size of IconTheme
    return null;
  }

  @override
  double get activeIconMargin {
    return (ACTION_LAYOUT_SIZE - ACTION_INNER_BUTTON_SIZE) / 4;
  }

  @override
  double get activeIconSize {
    return ACTION_INNER_BUTTON_SIZE;
  }

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(color: color, fontFamily: fontFamily);
  }
}
