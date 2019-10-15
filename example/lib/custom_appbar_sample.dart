import 'package:bulged_bottom_bar_example/color_item_view.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class CustomAppBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<CustomAppBarDemo> {
  int _currentIndex = 0;
  static const INDEX_PUBLISH = 2;
  List<TabItem> _navigationItems = <TabItem>[
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'Discovery'),
    TabItem(title: ''),
    TabItem(icon: Icons.message, title: 'Message'),
    TabItem(icon: Icons.people, title: 'Profile')
  ];

  static const paletteColors = [
    Color(0xFFf44336),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF673AB7),
    Color(0xFF3F51B5),
    Color(0xFF2196F3),
    Color(0xFF00BCD4),
    Color(0xFF009688),
    Color(0xFF4CAF50),
    Color(0xFF8BC34A),
    Color(0xFFCDDC39),
    Color(0xFFFFEB3B),
    Color(0xFFFFC107),
    Color(0xFFFF9800),
    Color(0xFFFF5722),
    Color(0xFF795548),
    Color(0xFF9E9E9E),
    Color(0xFF607D8B),
  ];
  Color _tabBackgroundColor = paletteColors[5];

  @override
  Widget build(BuildContext context) {
    var convexColor =
        _currentIndex == INDEX_PUBLISH ? Colors.white : Colors.white60;
    return Scaffold(
      appBar: AppBar(title: const Text('Custom ConvexAppBar')),
      body: paletteBody(),
      floatingActionButton: GestureDetector(
        onTap: () => _onItemTapped(INDEX_PUBLISH),
        child: fabContent(convexColor),
      ),
      floatingActionButtonLocation: ConvexAppBar.centerDocked,
      bottomNavigationBar: ConvexAppBar.builder(
          count: 5,
          backgroundColor: _tabBackgroundColor,
          builder: (BuildContext context, int index) {
            var data = _navigationItems[index];
            var color = _currentIndex == index ? Colors.white : Colors.white60;
            return GestureDetector(
                onTap: () => _onItemTapped(index),
                child: tabContent(data, color));
          }),
    );
  }

  Container tabContent(TabItem data, Color color) {
    return Container(
        height: 50,
        padding: EdgeInsets.only(bottom: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(data.icon, color: color),
            Text(data.title, style: TextStyle(color: color))
          ],
        ));
  }

  Container fabContent(Color convexColor) {
    return Container(
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
    );
  }

  GridView paletteBody() {
    return GridView.count(
      crossAxisCount: 5,
      childAspectRatio: 1,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      children: paletteColors
          .map((c) => GestureDetector(
                child: ColorItemView(c),
                onTap: () => _onColorChanged(c),
              ))
          .toList(),
    );
  }

  bool _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    return true;
  }

  void _onColorChanged(Color color) {
    setState(() {
      _tabBackgroundColor = color;
    });
  }
}
