import 'package:convex_bottom_bar/src/reused_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test Gradient', () {
    var gradient = ReusedGradient();
    gradient.gradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.redAccent, Colors.green, Colors.blue],
      tileMode: TileMode.repeated,
    );
    gradient.updateWith(Paint(), size: Rect.fromLTRB(0, 0, 10, 10));
    expect(gradient.valid, true);
  });
}
