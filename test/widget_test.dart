import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TabItem support IconData and Widget', () {
    var item = TabItem(title: 'Tab A', icon: Icons.add);
    expect(item != null, true);
    var item2 = TabItem(title: 'Tab A', icon: Container(child: Text('A')));
    expect(item2 != null, true);
    var item3;
    try {
      item3 = TabItem(title: 'Tab A', icon: 'A');
    } catch (_) {}
    expect(item3 != null, false);
  });

  testWidgets('TabStyle.fixed, all tab has icon and text',
      (WidgetTester tester) async {
    await tester.pumpWidget(material(ConvexAppBar(
      items: [
        TabItem(title: 'Tab A', icon: Icons.add),
        TabItem(title: 'Tab B', icon: Icons.near_me),
        TabItem(title: 'Tab C', icon: Icons.web),
      ],
    )));
    final tabAText = find.text('Tab A');
    final tabBText = find.text('Tab B');
    final tabCText = find.text('Tab C');
    expect(tabAText, findsOneWidget);
    expect(tabBText, findsOneWidget);
    expect(tabCText, findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.near_me), findsOneWidget);
    expect(find.byIcon(Icons.web), findsOneWidget);
  });

  testWidgets('TabStyle.reactCircle, selected tab has no text',
      (WidgetTester tester) async {
    await tester.pumpWidget(material(ConvexAppBar(
      items: [
        TabItem(title: 'Tab A', icon: Icons.add),
        TabItem(title: 'Tab B', icon: Icons.near_me),
        TabItem(title: 'Tab C', icon: Icons.web),
      ],
      style: TabStyle.reactCircle,
    )));
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Tab A'), findsNothing);
    expect(find.text('Tab B'), findsOneWidget);
    expect(find.text('Tab C'), findsOneWidget);
    // select tab B
    await tester.tap(find.byIcon(Icons.near_me));
    await tester.pump();
    expect(find.text('Tab A'), findsOneWidget);
    expect(find.text('Tab B'), findsNothing);
    expect(find.text('Tab C'), findsOneWidget);
  });

  testWidgets('TabStyle.textIn, only selected tab has text',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      material(
        ConvexAppBar(
          items: [
            TabItem(title: 'Tab A', icon: Icons.add),
            TabItem(title: 'Tab B', icon: Icons.near_me),
            TabItem(title: 'Tab C', icon: Icons.web),
          ],
          style: TabStyle.textIn,
        ),
      ),
      Duration(milliseconds: 300),
    );
    // selected tab has text
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Tab A'), findsOneWidget);

    expect(find.byIcon(Icons.near_me), findsOneWidget);
    expect(find.text('Tab B'), findsNothing);

    expect(find.byIcon(Icons.web), findsOneWidget);
    expect(find.text('Tab C'), findsNothing);

    // select tab B
    await tester.tap(find.byIcon(Icons.near_me));
    await tester.pumpAndSettle(Duration(milliseconds: 300));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.text('Tab A'), findsNothing);

    expect(find.byIcon(Icons.near_me), findsOneWidget);
    expect(find.text('Tab B'), findsOneWidget);

    expect(find.byIcon(Icons.web), findsOneWidget);
    expect(find.text('Tab C'), findsNothing);
  });
}

Widget material(Widget widget) {
  return Directionality(
    child: MediaQuery(
      data: MediaQueryData(),
      child: widget,
    ),
    textDirection: TextDirection.ltr,
  );
}
