import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'convex_shape.dart';

class ConvexPainter extends CustomPainter {
  final _paint = Paint();
  final _shadowPaint = Paint();
  final _shape = ConvexNotchedRectangle();
  final double width;
  final double height;
  final double top;

  ConvexPainter({
    this.top,
    this.width,
    this.height,
    Color color = Colors.white,
    Color shadowColor = Colors.black38,
    double sigma = 2,
  }) {
    _paint..color = color;
    _shadowPaint
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.outer, sigma);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect host = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect guest = Rect.fromLTWH(size.width / 2 - width / 2, top, width, height);
    Path path = _shape.getOuterPath(host, guest);
    canvas.drawPath(path, _shadowPaint);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
