import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:convex_bottom_bar/src/reused_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_test.dart';

void main() {
  testWidgets('Test StyleProvider', (WidgetTester tester) async {
    await tester.pumpWidget(material(StyleProvider(
      style: Style(),
      child: ConvexAppBar(
        items: [
          TabItem(icon: Icons.gradient, title: ''),
          TabItem(icon: Icons.help_outline, title: ''),
          TabItem(icon: Icons.work, title: ''),
        ],
      ),
    )));
  });
  testWidgets('Test Provider assertion, style should not be null', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(StyleProvider(
        style: null,
        child: null,
      ));
    }, throwsAssertionError);
  });
  testWidgets('Test Provider assertion, child should not be null', (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(StyleProvider(
        style: Style(),
        child: null,
      ));
    }, throwsAssertionError);
  });
}

/// testWidgets('MyWidget asserts invalid bounds', (WidgetTester tester) async {
///   await tester.pumpWidget(MyWidget(-1));
///   expect(tester.takeException(), isAssertionError); // or isNull, as appropriate.
/// });
class Style extends StyleHook {
  @override
  double get iconSize {
    return 10;
  }

  @override
  TextStyle textStyle(Color color) {
    return TextStyle(color: color);
  }

  @override
  double get activeIconSize {
    return 10;
  }

  @override
  double get activeIconMargin {
    return 1;
  }
}
