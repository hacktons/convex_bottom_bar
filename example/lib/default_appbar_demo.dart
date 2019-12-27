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
    TabItem(icon: Icons.add, title: "Publish"),
    TabItem(icon: Icons.message, title: 'Message'),
    TabItem(icon: Icons.people, title: 'Profile'),
  ];
  static const ACTIVE_COLOR = Colors.red;
  static const NORMAL_COLOR = Colors.black;

  var styles = [
    {"text": "TabStyle.fixed", "value": TabStyle.fixed},
    {"text": "TabStyle.fixedCircle", "value": TabStyle.fixedCircle},
    {"text": "TabStyle.scale", "value": TabStyle.scale},
    {"text": "TabStyle.pop", "value": TabStyle.pop},
  ];
  int style = 0;

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Default ConvexAppBar'),
      ),
      body: Column(
        children: [
          // ignore: sdk_version_ui_as_code
          ...List.generate(styles.length, (i) {
            var e = styles[i];
            return ListTile(
              title: Text(e['text']),
              trailing: Radio<int>(
                  value: i, groupValue: style, onChanged: handleStyle),
              onTap: () => handleStyle(i),
            );
          }),
          Expanded(
            child: Center(child: Text('click TAB $_selectedIndex')),
          )
        ],
      ),
      bottomNavigationBar: ConvexAppBar(
        items: TAB_ITEMS,
        style: styles[style]['value'],
        onTap: (int i) => setState(() {
          _selectedIndex = i;
        }),
      ),
    );
  }

  void handleStyle(int value) {
    setState(() {
      style = value;
    });
  }
}
