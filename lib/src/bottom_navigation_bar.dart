import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../convex_bottom_bar.dart';
import 'extend_location.dart';
import 'item.dart';
import 'another_notch.dart';
import 'image_button.dart';

/// A container that is typically used with [Scaffold.bottomNavigationBar], and
/// can have a notch along the top that makes room for an overlapping
/// [FloatingActionButton].
///
/// {@tool sample}
/// ```dart
/// Scaffold(
///  floatingActionButton: ConvexAppBar.fab(/* config */),
///  floatingActionButtonLocation: ConvexAppBar.centerDocked,
///  bottomNavigationBar: ConvexAppBar(/* config */),
/// )
/// ```
/// {@end-tool}
///
class ConvexAppBar extends StatefulWidget {
  /// The tab count, including the empty convex-center tab
  final int count;
  final _Delegate delegate;

  /// Color for the whole AppBar, if that's null then
  /// [ThemeData.bottomAppBarColor] is used.
  final Color backgroundColor;

  /// Create a AppBar with fixed tab array, tab style is predefined for convenient.
  ConvexAppBar(
      {Key key,
      @required List<TabItem> items,
      WillValueChanged<int> onTap,
      this.backgroundColor,
      int index,
      @required Color color,
      @required Color activeColor})
      : this.count = items.length,
        this.delegate = DefaultNavigationBar(
            items: items,
            onTap: onTap,
            color: color,
            activeColor: activeColor,
            selectedIndex: index),
        super(key: key);

  ///
  /// Custom the AppBar content with [ConvexAppBar.builder]
  /// {@tool sample}
  ///
  ///```dart
  /// Scaffold(
  ///   floatingActionButton: GestureDetector(
  ///     onTap: () => _onItemTapped(INDEX_PUBLISH),
  ///     child: fabContent(convexColor),
  ///   ),
  ///   floatingActionButtonLocation: ConvexAppBar.centerDocked,
  ///   bottomNavigationBar: ConvexAppBar.builder(
  ///       count: 5,
  ///       backgroundColor: _tabBackgroundColor,
  ///       builder: (BuildContext context, int index) => builderContent
  ///   ),
  /// ),
  ///```
  /// {@end-tool}
  ConvexAppBar.builder({
    Key key,
    this.backgroundColor,
    @required this.count,
    @required IndexedWidgetBuilder builder,
  })  : delegate = CustomNavigationBar(builder),
        super(key: key);

  @override
  _HomeBottomNavigationBarState createState() =>
      _HomeBottomNavigationBarState();

  /// default fab
  static Widget fab(
      {String text,
      IconData icon,
      bool active,
      Color color,
      Color activeColor,
      GestureTapCallback onTap}) {
    return GestureDetector(
      child: Container(
        width: 60,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(Icons.add, size: 50, color: active ? activeColor : color),
            Text(text, style: TextStyle(color: active ? activeColor : color)),
          ],
        ),
      ),
      onTap: onTap,
    );
  }

  static const FloatingActionButtonLocation centerDocked =
      ExtendLocation.centerDocked;
}

class CustomNavigationBar extends _Delegate {
  IndexedWidgetBuilder builder;

  CustomNavigationBar(this.builder);

  @override
  Widget build(BuildContext context, int index) {
    return builder(context, index);
  }
}

class DefaultNavigationBar extends _Delegate {
  final List<TabItem> items;

  final Color color;
  final Color activeColor;
  final WillValueChanged<int> onTap;
  final IndexedWidgetBuilder builder;
  int selectedIndex;

  DefaultNavigationBar(
      {this.items,
      this.color,
      this.activeColor,
      this.onTap,
      this.builder,
      this.selectedIndex});

  @override
  Widget build(BuildContext context, int index) {
    var navigationItem = items[index];
    var child = Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 2),
      child: ImageButton.icon(
        size: 23,
        normalIcon: navigationItem.icon,
        text: navigationItem.title,
        textColor: color,
        activeTextColor: activeColor,
        fontSize: 12,
        drawablePadding: 2,
        isActive: selectedIndex == index,
        onTap: () {
          if (onTap != null) {
            onTap(index);
          }
        },
      ),
    );
    return child;
  }
}

class _HomeBottomNavigationBarState<T> extends State<ConvexAppBar> {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    var count = widget.count;
    var builder = widget.delegate;
    for (var i = 0; i < count; i++) {
      children.add(builder.build(context, i));
    }

    return BottomAppBar(
        notchMargin: 0,
        color: widget.backgroundColor,
        shape: AnotherCircularNotchedRectangle(),
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: children,
        ));
  }
}

typedef WillValueChanged<T> = bool Function(T value);

abstract class _Delegate {
  Widget build(BuildContext context, int index);
}
