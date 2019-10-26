import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';
import 'painter.dart';

/// Default size of the curve line
const double CONVEX_SIZE = 80;

/// Default height of the AppBar
const double BAR_HEIGHT = 50;

/// Default distance that the child's top edge is inset from the top of the stack.
const double CURVE_TOP = -25;

const double ACTION_LAYOUT_SIZE = 60;
const double ACTION_INNER_BUTTON_SIZE = 50;
const int CURVE_INDEX = -1;
const double ELEVATION = 2;

class ConvexAppBar extends StatefulWidget {
  /// TAB item builder
  final DelegateBuilder tabBuilder;

  /// Tab Click handler
  final GestureTapIndexCallback onTap;
  final GestureTapCallback onTapActionButton;

  /// Fixed-Centered Button
  final DelegateBuilder actionBuilder;

  /// Color of the AppBar
  final Color backgroundColor;

  /// Tab count
  final int count;

  /// Height of the AppBar
  final double height;

  /// Size of the curve line
  final double curveSize;

  /// The distance that the [actionButton] top edge is inset from the top of the AppBar.
  final double top;

  /// Elevation for the bar top edge
  final double elevation;

  ConvexAppBar({
    Key key,
    @required List<TabItem> items,
    @required TabItem actionItem,
    this.onTap,
    this.onTapActionButton,
    Color color = Colors.black,
    Color activeColor = Colors.redAccent,
    this.backgroundColor = Colors.white,
    this.height = BAR_HEIGHT,
    this.curveSize = CONVEX_SIZE,
    this.top = CURVE_TOP,
    this.elevation = ELEVATION,
  })  : assert(items != null && items.isNotEmpty, 'items should not be empty'),
        assert(items.length % 2 == 0, 'item count should be even'),
        assert(top <= 0, 'top should be negative'),
        count = items.length,
        tabBuilder = _DefaultTabBuilder(
          items: items,
          color: color,
          activeColor: activeColor,
        ),
        actionBuilder = _DefaultActionButtonBuilder(
          item: actionItem,
          color: color,
          activeColor: activeColor,
        );

  ConvexAppBar.builder({
    @required CustomTabBuilder actionBuilder,
    @required CustomTabBuilder tabBuilder,
    @required this.count,
    this.onTap,
    this.onTapActionButton,
    this.backgroundColor = Colors.white,
    this.height = BAR_HEIGHT,
    this.curveSize = CONVEX_SIZE,
    this.top = CURVE_TOP,
    this.elevation = ELEVATION,
  })  : assert(count % 2 == 0, 'item count should be even'),
        assert(top <= 0, 'top should be negative'),
        tabBuilder = _CustomTabBuilder(tabBuilder),
        actionBuilder = _CustomTabBuilder(actionBuilder);

  @override
  _State createState() {
    return _State();
  }
}

abstract class DelegateBuilder {
  Widget build(BuildContext context, int index, bool active);
}

class _CustomTabBuilder extends DelegateBuilder {
  final CustomTabBuilder builder;

  _CustomTabBuilder(this.builder);

  @override
  Widget build(BuildContext context, int index, bool active) {
    return builder(context, index, active);
  }
}

class _DefaultTabBuilder extends DelegateBuilder {
  final List<TabItem> items;
  final Color activeColor;
  final Color color;

  _DefaultTabBuilder({this.items, this.activeColor, this.color});

  @override
  Widget build(BuildContext context, int index, bool active) {
    var navigationItem = items[index];
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
              active
                  ? navigationItem.activeIcon ?? navigationItem.icon
                  : navigationItem.icon,
              color: active ? activeColor : color),
          Text(
            navigationItem.title,
            style: TextStyle(color: active ? activeColor : color),
          )
        ],
      ),
    );
  }
}

class _DefaultActionButtonBuilder extends DelegateBuilder {
  final TabItem item;
  final Color activeColor;
  final Color color;

  _DefaultActionButtonBuilder({this.item, this.activeColor, this.color});

  @override
  Widget build(BuildContext context, int index, bool active) {
    return Container(
      height: ACTION_LAYOUT_SIZE,
      color: Colors.transparent,
      padding: EdgeInsets.only(bottom: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            active ? item.activeIcon ?? item.icon : item.icon,
            color: active ? activeColor : color,
            size: ACTION_INNER_BUTTON_SIZE,
          ),
          Text(
            item.title,
            style: TextStyle(color: active ? activeColor : color),
          )
        ],
      ),
    );
  }
}

class _State extends State<ConvexAppBar> {
  int _currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: ConvexPainter(
              top: widget.top,
              width: widget.curveSize,
              height: widget.curveSize,
              color: widget.backgroundColor,
              sigma: widget.elevation,
            ),
          ),
        ),
        barContent(),
        Positioned.fill(
          top: widget.top,
          child: FractionallySizedBox(
              widthFactor: 1 / widget.count,
              alignment: Alignment.center,
              child: GestureDetector(
                child: widget.actionBuilder.build(
                    context, CURVE_INDEX, CURVE_INDEX == _currentSelectedIndex),
                onTap: () {
                  //debugPrint('click action tab');
                  setState(() {
                    _currentSelectedIndex = CURVE_INDEX;
                  });
                  if (widget.onTapActionButton != null) {
                    widget.onTapActionButton();
                  }
                },
              )),
        ),
      ],
    );
  }

  Container barContent() {
    List<Widget> children = [];
    for (var i = 0; i < widget.count; i++) {
      children.add(Expanded(
          child: GestureDetector(
        child: widget.tabBuilder.build(context, i, _currentSelectedIndex == i),
        onTap: () {
          setState(() {
            _currentSelectedIndex = i;
          });
          _onTabClick(i);
        },
      )));
    }
    // add placeholder Widget
    var curveTabIndex = widget.count ~/ 2;
    children.insert(curveTabIndex, Expanded(child: Container()));
    return Container(
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  void _onTabClick(int i) {
    //debugPrint('click tab#$i');
    if (widget.onTap != null) {
      widget.onTap(i);
    }
  }
}

typedef GestureTapIndexCallback = void Function(int index);
typedef CustomTabBuilder = Widget Function(
    BuildContext context, int index, bool active);
