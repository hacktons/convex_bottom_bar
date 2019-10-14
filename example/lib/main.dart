import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selected = 0;
  static const INDEX_PUBLISH = 2;
  List<TabItem> _navigationItems = <TabItem>[
    TabItem(
      icon: Icons.home,
      title: 'Home',
    ),
    TabItem(
      icon: Icons.map,
      title: 'Discovery',
    ),
    TabItem(
      title: '',
    ),
    TabItem(
      icon: Icons.message,
      title: 'Message',
    ),
    TabItem(
      icon: Icons.people,
      title: 'Profile',
    )
  ];

  @override
  Widget build(BuildContext context) {
    var convexColor = _selected == INDEX_PUBLISH ? Colors.red : Colors.black;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Center(
          child: Text(
            'Tab : $_selected\n',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
        ),
        floatingActionButton: GestureDetector(
          onTap: () => _onItemTapped(INDEX_PUBLISH),
          child: Container(
            width: 60,
            height: 80,
            padding: EdgeInsets.only(bottom: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(Icons.add, size: 50, color: convexColor),
                Text('Publish', style: TextStyle(color: convexColor)),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: ExtendLocation.centerDocked,
        bottomNavigationBar: ConvexAppBar.builder(
            count: 5,
            builder: (BuildContext context, int index) {
              var data = _navigationItems[index];
              var color = _selected == index ? Colors.red : Colors.black;
              return GestureDetector(
                  onTap: () => _onItemTapped(index),
                  child: Container(
                      height: 50,
                      padding: EdgeInsets.only(bottom: 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Icon(data.icon, color: color),
                          Text(data.title, style: TextStyle(color: color))
                        ],
                      )));
            }),
      ),
    );
  }

  bool _onItemTapped(int index) {
    setState(() => _selected = index);
    debugPrint("click $index");
    return true;
  }
}
