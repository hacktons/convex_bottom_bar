import 'dart:math' as math;

import 'package:convex_bottom_bar/src/style/fixed_circle_tab_style.dart';
import 'package:convex_bottom_bar/src/style/fixed_tab_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';
import 'painter.dart';
import 'style/styles.dart';

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

enum TabStyle {
  /// convex tab fixed center, see [FixedTabStyle]
  fixed,

  /// convex tab is fixed center with circle, see [FixedCircleTabStyle]
  fixedCircle,
  scale,
  pop,
  custom,
}

class ConvexAppBar extends StatefulWidget {
  /// TAB item builder
  final DelegateBuilder tabBuilder;

  /// Tab Click handler
  final GestureTapIndexCallback onTap;
  final GestureTapCallback onTapActionButton;

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
  final TabStyle style;

  ConvexAppBar({
    Key key,
    @required List<TabItem> items,
    @Deprecated('is no loanger not supported ') TabItem actionItem,
    this.onTap,
    this.onTapActionButton,
    Color color = Colors.white60,
    Color activeColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.height = BAR_HEIGHT,
    this.curveSize = CONVEX_SIZE,
    this.top = CURVE_TOP,
    this.elevation = ELEVATION,
    this.style = TabStyle.fixed,
  })  : assert(items != null && items.isNotEmpty, 'items should not be empty'),
        assert(items.length % 2 == 1, 'item count should be even'),
        assert(top <= 0, 'top should be negative'),
        count = items.length,
        tabBuilder = supportedStyle(
          style,
          items: items,
          color: color,
          activeColor: activeColor,
          backgroundColor: backgroundColor,
        );

  ConvexAppBar.builder({
    @Deprecated('is no loanger not supported ') CustomTabBuilder actionBuilder,
    @required CustomTabBuilder tabBuilder,
    @required this.count,
    this.onTap,
    this.onTapActionButton,
    this.backgroundColor = Colors.blue,
    this.height = BAR_HEIGHT,
    this.curveSize = CONVEX_SIZE,
    this.top = CURVE_TOP,
    this.elevation = ELEVATION,
    this.style = TabStyle.custom,
  })  : assert(count % 2 == 1, 'item count should be even'),
        assert(top <= 0, 'top should be negative'),
        tabBuilder = _CustomTabBuilder(tabBuilder);

  @override
  _State createState() {
    return _State();
  }
}

abstract class DelegateBuilder {
  Widget build(BuildContext context, int index, bool active);

  bool fixed() {
    return false;
  }
}

class _CustomTabBuilder extends DelegateBuilder {
  final CustomTabBuilder builder;

  _CustomTabBuilder(this.builder);

  @override
  Widget build(BuildContext context, int index, bool active) {
    return builder(context, index, active);
  }
}

class _State extends State<ConvexAppBar> {
  int _currentSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    final convexIndex = isFixed() ? widget.count ~/ 2 : _currentSelectedIndex;
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: widget.height + additionalBottomPadding,
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
        barContent(additionalBottomPadding),
        Positioned.fill(
          top: widget.top,
          bottom: additionalBottomPadding,
          child: FractionallySizedBox(
              widthFactor: 1 / widget.count,
              alignment: Alignment.center,
              child: GestureDetector(
                child: widget.tabBuilder.build(
                    context, convexIndex, convexIndex == _currentSelectedIndex),
                onTap: () {
                  //debugPrint('click action tab');
                  setState(() {
                    _currentSelectedIndex = convexIndex;
                  });
                  if (widget.onTap != null) {
                    widget.onTap(convexIndex);
                  }
                },
              )),
        ),
      ],
    );
  }

  bool isFixed() => widget.tabBuilder.fixed();

  Container barContent(double paddingBottom) {
    List<Widget> children = [];
    // add placeholder Widget
    var curveTabIndex = widget.count ~/ 2;
    for (var i = 0; i < widget.count; i++) {
      if (i == curveTabIndex) {
        children.add(Expanded(child: Container()));
        continue;
      }
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

    return Container(
      height: widget.height + paddingBottom,
      padding: EdgeInsets.only(bottom: paddingBottom),
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
