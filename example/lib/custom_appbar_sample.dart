/*
 *  Copyright 2020 chaobinwu89@gmail.com
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

import 'color_item_view.dart';

class CustomAppBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<CustomAppBarDemo>
    with SingleTickerProviderStateMixin {
  List<TabItem> items = <TabItem>[
    TabItem(icon: Icons.home, title: 'Home'),
    TabItem(icon: Icons.map, title: 'Discovery'),
    TabItem(icon: Icons.plus_one, title: 'Add'),
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
    return DefaultTabController(
        initialIndex: 0,
        length: items.length,
        child: Scaffold(
          appBar: AppBar(title: const Text('Custom ConvexAppBar')),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: items
                .map((i) => i.title == 'Discovery'
                    ? paletteBody()
                    : Center(
                        child: Text(
                        '<\t\t${i.title}\t\t>',
                        style: TextStyle(fontSize: 30),
                      )))
                .toList(growable: false),
          ),
          bottomNavigationBar: StyleProvider(
            style: Style(),
            child: ConvexAppBar(
              disableDefaultTabController: true,
              initialActiveIndex: 0,
              height: 50,
              top: -30,
              curveSize: 100,
              style: TabStyle.fixedCircle,
              items: [
                TabItem(title: '2019', icon: Icons.link),
                TabItem(
                    icon: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFFF5722),
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 40),
                )),
                TabItem(title: "2020", icon: Icons.work),
              ],
              backgroundColor: _tabBackgroundColor,
              cornerRadius: 25,
              onTabNotify: (i) {
                var intercept = i == 1;
                if (intercept) {
                  Navigator.pushNamed(context, '/fab');
                }
                return !intercept;
              },
              onTap: (i) => debugPrint('click $i'),
            ),
          ),
        ));
  }

  Widget builder() {
    return ConvexAppBar.builder(
      itemBuilder: _CustomBuilder(items, _tabBackgroundColor),
      count: items.length,
      backgroundColor: _tabBackgroundColor,
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
            Text(data.title != null ? data.title! : "",
                style: TextStyle(color: color))
          ],
        ));
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

  void _onColorChanged(Color color) {
    setState(() {
      _tabBackgroundColor = color;
    });
  }
}

class _CustomBuilder extends DelegateBuilder {
  final List<TabItem> items;
  final Color _tabBackgroundColor;

  _CustomBuilder(this.items, this._tabBackgroundColor);

  @override
  Widget build(BuildContext context, int index, bool active) {
    var navigationItem = items[index];
    var _color = active ? Colors.white : Colors.white60;

    if (index == items.length ~/ 2) {
      return Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
        child: Icon(
          Icons.add,
          size: 40,
          color: _tabBackgroundColor,
        ),
      );
    }
    var _icon = active
        ? navigationItem.activeIcon ?? navigationItem.icon
        : navigationItem.icon;
    var _title = navigationItem.title ?? "";
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(_icon, color: _color),
          Text(_title, style: TextStyle(color: _color))
        ],
      ),
    );
  }

  @override
  bool fixed() {
    return true;
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => 40;

  @override
  double get activeIconMargin => 10;

  @override
  double get iconSize => 20;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(fontSize: 20, color: color, fontFamily: fontFamily);
  }
}
