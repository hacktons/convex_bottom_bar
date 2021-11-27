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

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'widget_test.dart';

void main() {
  testWidgets('Test StyleProvider', (WidgetTester tester) async {
    await tester.pumpWidget(material(StyleProvider(
        style: Style(),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ConvexAppBar(
            items: [
              TabItem(icon: Icons.gradient, title: ''),
              TabItem(icon: Icons.help_outline, title: ''),
              TabItem(icon: Icons.work, title: ''),
            ],
          ),
        ))));
  });
  // no longer needed for null safety
  /*testWidgets('Test Provider assertion, style should not be null',
      (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(StyleProvider(
        style: null,
        child: null,
      ));
    }, throwsAssertionError);
  });*/
  /*testWidgets('Test Provider assertion, child should not be null',
      (WidgetTester tester) async {
    expect(() async {
      await tester.pumpWidget(StyleProvider(
        style: Style(),
        child: null,
      ));
    }, throwsAssertionError);
  });*/
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
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(color: color, fontFamily: fontFamily);
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
