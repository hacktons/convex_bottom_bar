import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';
import 'another_notch.dart';
import 'image_button.dart';

class ConvexAppBar extends StatefulWidget {
  final int count;
  final _Delegate delegate;
  final Color backgroundColor;

  ConvexAppBar(
      {Key key,
      @required List<TabItem> items,
      WillValueChanged<int> onTap,
      this.backgroundColor,
      @required Color color,
      @required Color activeColor})
      : this.count = items.length,
        this.delegate = DefaultNavigationBar(
            items: items, onTap: onTap, color: color, activeColor: activeColor),
        super(key: key);

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
}

class CustomNavigationBar extends _Delegate {
  IndexedWidgetBuilder builder;

  CustomNavigationBar(this.builder);

  @override
  Widget build(BuildContext context, int index, DataProvider provider) {
    return builder(context, index);
  }
}

class DefaultNavigationBar extends _Delegate {
  final List<TabItem> items;

  final Color color;
  final Color activeColor;
  final WillValueChanged<int> onTap;
  final IndexedWidgetBuilder builder;

  DefaultNavigationBar(
      {this.items, this.color, this.activeColor, this.onTap, this.builder});

  @override
  Widget build(BuildContext context, int index, DataProvider provider) {
    var navigationItem = items[index];
    int _currentIndex = provider.get() ?? 0;
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
        isActive: _currentIndex == index,
        onTap: () {
          if (onTap != null) {
            if (onTap(index)) {
              provider.setData(index);
            }
          } else {
            provider.setData(index);
          }
        },
      ),
    );
    return child;
  }
}

class _HomeBottomNavigationBarState<T> extends State<ConvexAppBar>
    implements DataProvider {
  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];
    var count = widget.count;
    var builder = widget.delegate;
    for (var i = 0; i < count; i++) {
      children.add(builder.build(context, i, this));
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

  dynamic _data;

  @override
  dynamic get() {
    return _data;
  }

  @override
  setData(dynamic data) {
    _data = data;
  }
}

typedef WillValueChanged<T> = bool Function(T value);

abstract class DataProvider<T> {
  T get();

  setData(T data);
}

abstract class _Delegate {
  Widget build(BuildContext context, int index, DataProvider provider);
}
