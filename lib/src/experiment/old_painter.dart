import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class ConvexPainter extends CustomPainter {
  final Paint _paint = Paint();
  final double curve = 10;
  final double sigma = 4;
  final Color shadowColor;
  final _shadowPaint = Paint();
  final gap = 0;

  ConvexPainter(Color color, {this.shadowColor = Colors.black38}) {
    _paint..color = color;

    _shadowPaint
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, sigma);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Rect before = Rect.fromLTWH(0, size.height / 2 - curve, curve, curve);
    Rect middle = Rect.fromLTWH(
        curve, curve + gap, size.width - curve * 2, size.height - curve - gap);
    Rect after = Rect.fromLTWH(
        size.width - curve, size.height / 2 - curve, curve, curve);
    path
      ..arcTo(before, radians(0), radians(90), false)
      ..lineTo(curve, size.height / 2)
      ..arcTo(middle, radians(0), radians(-180), false)
      ..moveTo(size.width - curve, size.height / 2)
      ..arcTo(after, radians(180), radians(-90), false)
      ..close();
    canvas.drawPath(path, _shadowPaint);
    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

/// Convert [degrees] to radians.
double radians(double degrees) => degrees * degrees2Radians;

/// Constant factor to convert and angle from degrees to radians.
const double degrees2Radians = math.pi / 180.0;
