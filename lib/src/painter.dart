import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'convex_shape.dart';

class ConvexPainter extends CustomPainter {
  final Paint _paint = Paint();
  final shape = ConvexNotchedRectangle();
  final double width;
  final double height;
  final double top;
  final Color color;
  final Color shadowColor;
  final _shadowPaint = Paint();

  ConvexPainter({
    this.top,
    this.width,
    this.height,
    this.color = Colors.white,
    this.shadowColor = Colors.black38,
  }) {
    _paint..color = color;
    _shadowPaint
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 4);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect host = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect guest = Rect.fromLTWH(size.width / 2 - width / 2, top, width, height);
    Path path = shape.getOuterPath(host, guest);
    canvas.drawPath(path, _shadowPaint);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
