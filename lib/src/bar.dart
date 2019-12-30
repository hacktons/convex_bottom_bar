import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'item.dart';
import 'painter.dart';
import 'style/fixed_circle_tab_style.dart';
import 'style/fixed_tab_style.dart';
import 'style/react_circle_tab_style.dart';
import 'style/react_tab_style.dart';
import 'style/styles.dart';

/// Default size of the curve line
const double CONVEX_SIZE = 80;

/// Default height of the AppBar
const double BAR_HEIGHT = 50;

/// Default distance that the child's top edge is inset from the top of the stack.
const double CURVE_TOP = -25;

const double ACTION_LAYOUT_SIZE = 60;
const double ACTION_INNER_BUTTON_SIZE = 40;
const int CURVE_INDEX = -1;
const double ELEVATION = 2;

enum TabStyle {
  /// convex shape fixed center, see [FixedTabStyle]
  fixed,

  /// convex shape is fixed center with circle, see [FixedCircleTabStyle]
  fixedCircle,

  /// convex shape is moved after selection, see [ReactTabStyle]
  react,

  /// convex shape is moved with circle after selection, see [ReactCircleTabStyle]
  reactCircle,
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

  /// Style to describe the convex shape
  final TabStyle style;

  /// The curve to use in the forward direction. Only works when tab style is not fixed.
  final Curve curve;

  ConvexAppBar({
    Key key,
    @required List<TabItem> items,
    @Deprecated('is no loanger not supported ') TabItem actionItem,
    this.onTap,
    this.onTapActionButton,
    Color color = Colors.white60,
    Color activeColor = Colors.white,
    this.backgroundColor = Colors.blue,
    this.height,
    this.curveSize,
    this.top = CURVE_TOP,
    this.elevation,
    this.style = TabStyle.fixed,
    this.curve = Curves.easeInOut,
  })  : assert(items != null && items.isNotEmpty, 'items should not be empty'),
        assert(items.length % 2 == 1, 'item count should be an odd number'),
        assert(top <= 0, 'top should be negative'),
        count = items.length,
        tabBuilder = supportedStyle(
          style,
          items: items,
          color: color,
          activeColor: activeColor,
          backgroundColor: backgroundColor,
          curve: curve,
        );

  ConvexAppBar.builder({
    @Deprecated('is no loanger not supported ') CustomTabBuilder actionBuilder,
    @required CustomTabBuilder tabBuilder,
    @required this.count,
    this.onTap,
    this.onTapActionButton,
    this.backgroundColor = Colors.blue,
    this.height,
    this.curveSize,
    this.top = CURVE_TOP,
    this.elevation,
    this.style = TabStyle.custom,
    this.curve = Curves.easeInOut,
  })  : assert(count % 2 == 1, 'item count should be an odd number'),
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

class _State extends State<ConvexAppBar> with TickerProviderStateMixin {
  int _currentSelectedIndex = 0;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    if (!isFixed()) {
      _initAnimation();
    }
    super.initState();
  }

  Animation<double> _initAnimation({int from, int to}) {
    if (from != null && (from == to)) {
      return _animation;
    }
    from ??= 0;
    to ??= from;
    var lower = (2 * from + 1) / (2 * widget.count);
    var upper = (2 * to + 1) / (2 * widget.count);
    debugPrint("tab index $from => $to");
    debugPrint("$lower => $upper");
    _controller = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );
    final Animation curve = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _animation = Tween(begin: lower, end: upper).animate(curve);
    return _animation;
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    var halfSize = widget.count ~/ 2;
    final convexIndex = isFixed() ? halfSize : _currentSelectedIndex;
    final active = isFixed() ? convexIndex == _currentSelectedIndex : true;
    return Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: widget.height ?? BAR_HEIGHT + additionalBottomPadding,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: ConvexPainter(
              top: widget.top,
              width: widget.curveSize ?? CONVEX_SIZE,
              height: widget.curveSize ?? CONVEX_SIZE,
              color: widget.backgroundColor,
              sigma: widget.elevation ?? ELEVATION,
              leftPercent: isFixed()
                  ? const AlwaysStoppedAnimation<double>(0.5)
                  : _animation ?? _initAnimation(),
            ),
          ),
        ),
        barContent(additionalBottomPadding),
        Positioned.fill(
          top: widget.top,
          bottom: additionalBottomPadding,
          child: FractionallySizedBox(
              widthFactor: 1 / widget.count,
              alignment: Alignment((convexIndex - halfSize) / (halfSize), 0),
              child: GestureDetector(
                child: widget.tabBuilder.build(context, convexIndex, active),
                onTap: () {
                  _onTabClick(convexIndex);
                  setState(() {
                    _currentSelectedIndex = convexIndex;
                  });
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
    var curveTabIndex = isFixed() ? widget.count ~/ 2 : _currentSelectedIndex;
    for (var i = 0; i < widget.count; i++) {
      if (i == curveTabIndex) {
        debugPrint('place holder =>$i');
        children.add(Expanded(child: Container()));
        continue;
      }
      children.add(Expanded(
          child: GestureDetector(
        child: widget.tabBuilder.build(context, i, _currentSelectedIndex == i),
        onTap: () {
          _onTabClick(i);
          setState(() {
            _currentSelectedIndex = i;
          });
        },
      )));
    }

    return Container(
      height: widget.height ?? BAR_HEIGHT + paddingBottom,
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  void _onTabClick(int i) {
    _initAnimation(from: _currentSelectedIndex, to: i);
    _controller?.forward();
    if (widget.onTap != null) {
      widget.onTap(i);
    }
  }
}

typedef GestureTapIndexCallback = void Function(int index);
typedef CustomTabBuilder = Widget Function(
    BuildContext context, int index, bool active);
