import 'package:flutter/cupertino.dart';

class Clipper extends CustomClipper<Rect> {
  final double percent;

  Clipper(this.percent);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, size.width, size.height * percent);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
