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

import 'package:flutter/painting.dart';

/// Wrapper for [Gradient], we don't want to re-create instance frequently in
/// hot method, such as paint().
class ReusedGradient {
  Gradient? _gradient;

  Shader? _shader;
  Rect? _size;

  /// Create gradient
  ReusedGradient();

  /// Setter to reset the [Gradient] instance
  set gradient(Gradient? gradient) {
    _gradient = gradient;
    _size = null;
  }

  /// Update the paint with provided size
  void updateWith(Paint paint, {Rect? size}) {
    if (size == _size || size == null) {
      return;
    }
    if (_gradient == null) {
      return;
    }
    _shader ??= _gradient!.createShader(size);
    paint.shader = _shader;
    _size = size;
  }

  /// check if the gradient is valid or not
  bool get valid {
    return _size != null && _gradient != null;
  }
}
