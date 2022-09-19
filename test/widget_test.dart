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
import 'package:convex_bottom_bar/src/style/blend_image_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TabItem support IconData and Widget', () {
    var item = TabItem(title: 'Tab A', icon: Icons.add);
    expect(item.title, 'Tab A');
    var item2 = TabItem(title: 'Tab A', icon: Container(child: Text('A')));
    expect(item2.icon is Container, true);
    expect(() async {
      TabItem(title: 'Tab A', icon: 'A');
    }, throwsAssertionError);
  });

  testWidgets('TabStyle.fixed, all tab has icon and text',
      (WidgetTester tester) async {
    var key = GlobalKey<ConvexAppBarState>();
    var tabController =
        TabController(length: 3, vsync: tester, initialIndex: 2);
    await tester.pumpWidget(material(ConvexAppBar(
      key: key,
      controller: tabController,
      items: [
        TabItem(title: 'Tab A', icon: Icons.add),
        TabItem(title: 'Tab B', icon: Icons.near_me),
        TabItem(title: 'Tab C', icon: Icons.web),
      ],
      style: TabStyle.fixed,
      cornerRadius: 25,
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
    key.currentState?.tap(2);
    expect(2, tabController.index);
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

  testWidgets('All TabStyle', (WidgetTester tester) async {
    for (var s in [
      TabStyle.fixed,
      TabStyle.fixedCircle,
      TabStyle.react,
      TabStyle.reactCircle,
      TabStyle.textIn,
      TabStyle.titled,
      TabStyle.flip,
      null,
    ]) {
      await tester.pumpWidget(
        material(DefaultTabController(
          length: 3,
          child: ConvexAppBar(
            key: ObjectKey(s),
            items: [
              TabItem(title: 'Tab A', icon: Icons.add),
              TabItem(title: 'Tab B', icon: Icons.near_me),
              TabItem(title: 'Tab C', icon: Icons.web),
            ],
            style: s,
          ),
        )),
        Duration(milliseconds: 300),
      );
      await tester.tap(find.byIcon(Icons.near_me).first, warnIfMissed: false);
      await tester.pumpAndSettle(Duration(milliseconds: 300));
      await tester.drag(find.byType(ConvexAppBar), Offset(200, 0),
          warnIfMissed: false);
      await tester.drag(find.byType(ConvexAppBar), Offset(-200, 0),
          warnIfMissed: false);
      await tester.pumpAndSettle(Duration(milliseconds: 300));
      await tester.startGesture(Offset(0, 100)).then((g) {
        return g.moveTo(Offset(500, 100));
      });
      await tester.startGesture(Offset(0, 100)).then((g) {
        return g.moveTo(Offset(100, 100));
      });
      print('style=$s');
      if (s != TabStyle.titled) {
        await tester.tap(find.byIcon(Icons.web).first);
        await tester.pumpAndSettle(Duration(milliseconds: 300));
        await tester.tap(find.byIcon(Icons.near_me).first);
        await tester.pumpAndSettle(Duration(milliseconds: 300));
      } else {
        await tester.tap(find.text('Tab A').first);
        await tester.pumpAndSettle(Duration(milliseconds: 300));
        await tester.tap(find.byIcon(Icons.add).first);
        await tester.pumpAndSettle(Duration(milliseconds: 300));
      }
    }
    await tester.pumpWidget(
      material(DefaultTabController(
        length: 3,
        child: ConvexAppBar(
          items: [
            TabItem(title: 'Tab A', icon: Icons.add),
            TabItem(title: 'Tab B', icon: Icons.near_me),
            TabItem(title: 'Tab C', icon: Icons.web),
          ],
          style: TabStyle.textIn,
        ),
      )),
    );
    await tester.tap(find.byIcon(Icons.near_me).first, warnIfMissed: false);
  });

  testWidgets('Test tab controller', (WidgetTester tester) async {
    var controller =
        TabController(length: 3, vsync: TestVSync(), initialIndex: 2);
    var key = GlobalKey<ConvexAppBarState>(debugLabel: 'appbar');
    var appbar = ConvexAppBar.builder(
      key: key,
      controller: controller,
      itemBuilder: Builder(),
      count: 3,
      top: -20,
      onTap: (i) {
        expect(i, 1);
      },
    );
    await tester.pumpWidget(
      // material(appbar),
      material(Scaffold(
        body: TabBarView(
          controller: controller,
          children: const <Widget>[
            Center(child: Text('CHILD 0')),
            Center(child: Text('CHILD 1')),
            Center(child: Text('CHILD 2')),
          ],
        ),
        bottomNavigationBar: appbar,
      )),
      Duration(milliseconds: 300),
    );
    expect(key.currentState?.currentIndex, 2);
    expect(find.text('TAB 0'), findsOneWidget);
    expect(find.text('TAB 1'), findsOneWidget);
    expect(find.text('TAB 2'), findsOneWidget);
    expect(find.text('CHILD 2'), findsOneWidget);

    await tester.tap(find.text('TAB 1'));
    await tester.tap(find.text('TAB 1'));
    await tester.pumpAndSettle(Duration(milliseconds: 300));
    expect(controller.index, 1);
    expect(key.currentState?.currentIndex, 1);

    await tester.drag(find.text('CHILD 1'), Offset(1000, 0));
    await tester.pumpAndSettle(Duration(milliseconds: 300));
    expect(controller.index, 0);
    expect(key.currentState?.currentIndex, 0);

    controller.animateTo(2);
    await tester.pumpAndSettle(Duration(milliseconds: 300));
    expect(controller.index, 2);
    expect(key.currentState?.currentIndex, 2);

    // Test a custom controller accidentally used with the DefaultTabController
    controller.index = 2;
    await tester.pumpWidget(
      material(DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: material(Scaffold(
          body: TabBarView(
            controller: controller,
            children: const <Widget>[
              Center(child: Text('CHILD 0')),
              Center(child: Text('CHILD 1')),
              Center(child: Text('CHILD 2')),
            ],
          ),
          bottomNavigationBar: ConvexAppBar.builder(
            key: key,
            controller: controller,
            itemBuilder: Builder(),
            count: 3,
            top: -20,
            onTap: (i) {
              assert(i == 1);
            },
          ),
        )),
      )),
      Duration(milliseconds: 300),
    );
    expect(key.currentState?.currentIndex, 2);
    await tester.flingFrom(Offset(0, 100), const Offset(600, 100), 10000.0);
    await tester.pumpAndSettle(Duration(milliseconds: 300));
    expect(controller.index, 1);
    expect(key.currentState?.currentIndex, 1);
  });

  testWidgets('Add badge on AppBar', (WidgetTester tester) async {
    await tester.pumpWidget(
      material(
        ConvexAppBar.badge(
          {
            0: '1',
            1: Duration(seconds: 0), // invalid type
            2: Colors.redAccent,
            3: Icons.add,
            4: Text('new'),
          },
          badgeMargin: EdgeInsets.only(left: 20, top: 20),
          items: [
            TabItem(title: 'Tab A', icon: Icons.add),
            TabItem(title: 'Tab B', icon: Icons.near_me),
            TabItem(title: 'Tab C', icon: Icons.web),
            TabItem(title: 'Tab D', icon: Icons.new_releases),
            TabItem(title: 'Tab E', icon: Container(width: 60, height: 60)),
          ],
          style: TabStyle.textIn,
        ),
      ),
      Duration(milliseconds: 300),
    );
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.near_me));
    await tester.pumpAndSettle(Duration(milliseconds: 300));
  });

  testWidgets('make appbar with builder', (WidgetTester tester) async {
    await tester.pumpWidget(
      material(
        ConvexAppBar.builder(
          itemBuilder: Builder(),
          count: 3,
          top: -20,
          onTap: (i) {
            assert(i == 1);
          },
        ),
      ),
      Duration(milliseconds: 300),
    );
    expect(find.text('TAB 0'), findsOneWidget);
    expect(find.text('TAB 1'), findsOneWidget);
    await tester.tap(find.text('TAB 1'));
    await tester.tap(find.text('TAB 1'));
    await tester.pumpAndSettle(Duration(milliseconds: 300));
  });

  // no longer needed for null safety
  /*test('test invalid builder', () {
    try {
      ConvexAppBar.builder(
        itemBuilder: null,
        count: 3,
        top: -20,
        onTap: (i) {
          assert(i == 1);
        },
      );
    } catch (e) {
      expect(e, isAssertionError);
    }
  });*/
  testWidgets(
    'Test invalid initialActiveIndex',
    (WidgetTester tester) async {
      try {
        await tester.pumpWidget(ConvexAppBar(
          items: [
            TabItem(title: 'A', icon: Icons.add),
            TabItem(title: 'B', icon: Icons.add),
            TabItem(title: 'C', icon: Icons.add)
          ],
          initialActiveIndex: 3,
          top: -20,
          onTap: (i) {
            assert(i == 1);
          },
        ));
      } catch (e) {
        // takeException is not working here
        expect(e, isAssertionError);
      }

      // await tester.pumpWidget(
      //   DefaultTabController(
      //     child: ConvexAppBar(
      //       items: [
      //         TabItem(title: 'A', icon: Icons.add),
      //         TabItem(title: 'B', icon: Icons.add),
      //         TabItem(title: 'C', icon: Icons.add)
      //       ],
      //       initialActiveIndex: 2,
      //     ),
      //     length: 3,
      //   ),
      //   Duration(milliseconds: 1000),
      // );
      //
      // expect(tester.takeException(), isAssertionError);
    },
  );

  testWidgets(
    'Test invalid cornerRadius configuration',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        ConvexAppBar(
          items: [
            TabItem(title: 'A', icon: Icons.add),
            TabItem(title: 'B', icon: Icons.add),
            TabItem(title: 'C', icon: Icons.add)
          ],
          cornerRadius: 25,
        ),
        Duration(milliseconds: 300),
      );
      expect(tester.takeException(), isAssertionError);
      try {
        await tester.pumpWidget(
          ConvexAppBar(
            items: [
              TabItem(title: 'A', icon: Icons.add),
              TabItem(title: 'B', icon: Icons.add),
              TabItem(title: 'C', icon: Icons.add)
            ],
            cornerRadius: -25,
          ),
          Duration(milliseconds: 300),
        );
      } catch (e) {
        expect(e, isAssertionError);
      }
    },
  );

  testWidgets('Test Blend Image', (WidgetTester tester) async {
    await tester.pumpWidget(
      BlendImageIcon(Container(width: 20, height: 20), color: Colors.red),
    );
  });

  testWidgets('Test Convex Button', (WidgetTester tester) async {
    await tester.pumpWidget(
      material(ConvexButton.fab()),
    );
  });
  testWidgets('Test event block', (WidgetTester tester) async {
    await tester.pumpWidget(
      material(ConvexAppBar(
        items: [
          TabItem(title: 'A', icon: Icons.add),
          TabItem(title: 'B', icon: Icons.add),
          TabItem(title: 'C', icon: Icons.add)
        ],
        onTabNotify: (_) {
          assert(_ == 1);
          return false;
        },
      )),
      Duration(milliseconds: 300),
    );
    await tester.tap(find.text('B'));
  });
}

class Builder extends DelegateBuilder {
  @override
  Widget build(BuildContext context, int index, bool active) {
    return Text('TAB $index');
  }
}

Widget material(Widget widget) {
  return Directionality(
    textDirection: TextDirection.ltr,
    child: MediaQuery(
      data: MediaQueryData(),
      child: widget,
    ),
  );
}
