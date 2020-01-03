import 'package:flutter/cupertino.dart';

class ReusedGradient {
  Gradient _gradient;

  Shader _shader;
  Rect _size;

  ReusedGradient();

  set gradient(Gradient gradient) {
    _gradient = gradient;
    _size = null;
  }

  updateWith(Paint paint, {Rect size}) {
    if (size == _size) {
      return;
    }
    if (_gradient == null) {
      return;
    }
    _shader ??= _gradient.createShader(size);
    paint.shader = _shader;
    _size = size;
  }
}
