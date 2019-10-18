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
      bottomNavigationBar: ConvexAppBar(
        items: TAB_ITEMS,
        onTap: (int i) => setState(() {
          _selectedIndex = i;
        }),
        actionItem: const TabItem(icon: Icons.add, title: "Publish"),
        onTapActionButton: () => setState(() {
          _selectedIndex = -1;
        }),
      ),
    );
  }
}
