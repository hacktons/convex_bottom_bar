import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class DefaultAppBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<DefaultAppBarDemo> {
  int _selectedIndex = 0;
  static const INDEX_PUBLISH = 2;
  static const TAB_ITEMS = const <TabItem>[
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'Discovery'),
    TabItem(title: ''),
    TabItem(icon: Icons.message, title: 'Message'),
    TabItem(icon: Icons.people, title: 'Profile')
  ];
  static const ACTIVE_COLOR = Colors.red;
  static const NORMAL_COLOR = Colors.black;

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default ConvexAppBar'),
      ),
      body: Center(
        child: Text('TAB $_selectedIndex', style: TextStyle(fontSize: 20)),
      ),
      floatingActionButton: ConvexAppBar.fab(
        text: 'Publish',
        active: _selectedIndex == INDEX_PUBLISH,
        activeColor: ACTIVE_COLOR,
        color: NORMAL_COLOR,
        onTap: () => onTabSelected(INDEX_PUBLISH),
      ),
      floatingActionButtonLocation: ConvexAppBar.centerDocked,
      bottomNavigationBar: ConvexAppBar(
        items: TAB_ITEMS,
        index: _selectedIndex,
        activeColor: ACTIVE_COLOR,
        color: NORMAL_COLOR,
        onTap: onTabSelected,
      ),
    );
  }

  bool onTabSelected(int index) {
    debugPrint('click $index');
    setState(() {
      _selectedIndex = index;
    });
    return true;
  }
}
