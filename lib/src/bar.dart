import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'chip_builder.dart';
import 'item.dart';
import 'painter.dart';
import 'stack.dart' as extend;
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
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-fixed.gif)
  fixed,

  /// convex shape is fixed center with circle, see [FixedCircleTabStyle]
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-fixed-circle.gif)
  fixedCircle,

  /// convex shape is moved after selection, see [ReactTabStyle]
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-react.gif)
  react,

  /// convex shape is moved with circle after selection, see [ReactCircleTabStyle]
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-react-circle.gif)
  reactCircle,

  /// tab icon, text animated with pop transition
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-textIn.gif)
  textIn,

  /// similar to [TabStyle.textIn], text first
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-titled.gif)
  titled,

  /// tab item is flipped when selected, does not support [flutter web]
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-flip.gif)
  flip,

  /// user defined style
  custom,
}

/// Online example can be found at http://hacktons.cn/convex_bottom_bar
///
/// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-theming.png)
class ConvexAppBar extends StatefulWidget {
  /// TAB item builder
  final DelegateBuilder itemBuilder;

  final ChipBuilder chipBuilder;

  /// Tab Click handler
  final GestureTapIndexCallback onTap;

  /// Tab controller to work with [TabBarView] or [PageView]
  final TabController tabController;

  /// Color of the AppBar
  final Color backgroundColor;

  /// If provided, backgroundColor for tab app will be ignored
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-gradient.gif)
  final Gradient gradient;

  /// The initial active index, you can config initialIndex of [TabController] if work with [TabBarView] or [PageView];
  final int initialActiveIndex;

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

  /// Construct a new appbar with internal style
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// ConvexAppBar(
  ///   items: [
  ///     TabItem(title: 'Tab A', icon: Icons.add),
  ///     TabItem(title: 'Tab B', icon: Icons.near_me),
  ///     TabItem(title: 'Tab C', icon: Icons.web),
  ///   ],
  /// )
  /// ```
  /// {@end-tool}
  ConvexAppBar({
    Key key,
    @required List<TabItem> items,
    int initialActiveIndex,
    GestureTapIndexCallback onTap,
    TabController tabController,
    Color color,
    Color activeColor,
    Color backgroundColor,
    Gradient gradient,
    double height,
    double curveSize,
    double top,
    double elevation,
    TabStyle style = TabStyle.reactCircle,
    Curve curve = Curves.easeInOut,
    ChipBuilder chipBuilder,
  }) : this.builder(
          key: key,
          itemBuilder: supportedStyle(
            style,
            items: items,
            color: color ?? Colors.white60,
            activeColor: activeColor ?? Colors.white,
            backgroundColor: backgroundColor ?? Colors.blue,
            curve: curve ?? Curves.easeInOut,
          ),
          onTap: onTap,
          tabController: tabController,
          backgroundColor: backgroundColor ?? Colors.blue,
          count: items.length,
          initialActiveIndex: initialActiveIndex,
          gradient: gradient,
          height: height,
          curveSize: curveSize,
          top: top,
          elevation: elevation,
          style: style,
          curve: curve ?? Curves.easeInOut,
          chipBuilder: chipBuilder,
        );

  /// define a custom tab style by implement a [DelegateBuilder]
  const ConvexAppBar.builder({
    Key key,
    @required this.itemBuilder,
    @required this.count,
    this.initialActiveIndex,
    this.onTap,
    this.tabController,
    this.backgroundColor,
    this.gradient,
    this.height,
    this.curveSize,
    this.top,
    this.elevation,
    this.style = TabStyle.reactCircle,
    this.curve = Curves.easeInOut,
    this.chipBuilder,
  })  : assert(top == null || top <= 0, 'top should be negative'),
        assert(itemBuilder != null, 'provide custom buidler'),
        assert(initialActiveIndex == null || initialActiveIndex < count,
            'initial index should < $count'),
        super(key: key);

  /// Construct a new appbar with badge
  ///
  /// {@animation 1010 598 https://github.com/hacktons/convex_bottom_bar/raw/master/doc/badge-demo.mp4}
  ///
  /// [badge] is map with tab items, the value of entry can be either [String],
  /// [IconData], [Color] or [Widget].
  ///
  /// {@tool sample}
  ///
  /// ```dart
  /// ConvexAppBar.badge(
  ///   {3: '99+'},
  ///   items: [
  ///     TabItem(title: 'Tab A', icon: Icons.add),
  ///     TabItem(title: 'Tab B', icon: Icons.near_me),
  ///     TabItem(title: 'Tab C', icon: Icons.web),
  ///   ],
  /// )
  /// ```
  /// {@end-tool}
  factory ConvexAppBar.badge(
    Map<int, dynamic> badge, {
    Key key,
    // config for badge
    Color badgeTextColor,
    Color badgeColor,
    EdgeInsets badgePadding,
    double badgeBorderRadius,
    // parameter for appbar
    List<TabItem> items,
    int initialActiveIndex,
    GestureTapIndexCallback onTap,
    TabController tabController,
    Color color,
    Color activeColor,
    Color backgroundColor,
    Gradient gradient,
    double height,
    double curveSize,
    double top,
    double elevation,
    TabStyle style,
    Curve curve,
  }) {
    DefaultChipBuilder chipBuilder;
    if (badge != null && badge.isNotEmpty) {
      chipBuilder = DefaultChipBuilder(
        badge,
        textColor: badgeTextColor,
        badgeColor: badgeColor,
        padding: badgePadding,
        borderRadius: badgeBorderRadius,
      );
    }
    return ConvexAppBar(
      key: key,
      items: items,
      initialActiveIndex: initialActiveIndex,
      onTap: onTap,
      tabController: tabController,
      color: color,
      activeColor: activeColor,
      backgroundColor: backgroundColor,
      gradient: gradient,
      height: height,
      curveSize: curveSize,
      top: top,
      elevation: elevation,
      style: style,
      curve: curve,
      chipBuilder: chipBuilder,
    );
  }

  @override
  _State createState() {
    return _State();
  }
}

/// Item builder
abstract class DelegateBuilder {
  /// called when the tab item is build
  Widget build(BuildContext context, int index, bool active);

  /// whether the convex shape is fixed center or positioned according to selection
  bool fixed() {
    return false;
  }
}

class _State extends State<ConvexAppBar> with TickerProviderStateMixin {
  int _currentIndex;
  Animation<double> _animation;
  AnimationController _controller;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _updateTabController();
    _currentIndex = widget.initialActiveIndex ?? _tabController?.index ?? 0;

    /// When both ConvexAppBar and TabController are configured with initial index, there can be conflict;
    /// We use ConvexAppBar's value;
    if (widget.initialActiveIndex != null &&
        _tabController != null &&
        widget.initialActiveIndex != _tabController.index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tabController.index = _currentIndex;
      });
    }
    if (!isFixed()) {
      _initAnimation();
    }
  }

  void _handleTabControllerAnimationTick({bool force = false}) {
    if (!force && _tabController.indexIsChanging) {
      return;
    }
    if (_tabController.index != _currentIndex) {
      _warpToCurrentIndex(_tabController.index);
    }
  }

  Future<void> _warpToCurrentIndex(int index) async {
    _initAnimation(from: _currentIndex, to: index);
    _controller?.forward();
    setState(() {
      _currentIndex = index;
    });
  }

  Animation<double> _initAnimation({int from, int to}) {
    if (from != null && (from == to)) {
      return _animation;
    }
    from ??= widget.initialActiveIndex ?? 0;
    to ??= from;
    var lower = (2 * from + 1) / (2 * widget.count);
    var upper = (2 * to + 1) / (2 * widget.count);
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

  _updateTabController() {
    final TabController newController =
        widget.tabController ?? DefaultTabController.of(context);
    _tabController?.removeListener(_handleTabControllerAnimationTick);
    _tabController = newController;
    _tabController?.addListener(_handleTabControllerAnimationTick);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();
  }

  @override
  void didUpdateWidget(ConvexAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.tabController != oldWidget.tabController) {
      _updateTabController();
    }
  }

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    var halfSize = widget.count ~/ 2;
    final convexIndex = isFixed() ? halfSize : _currentIndex;
    final active = isFixed() ? convexIndex == _currentIndex : true;
    return extend.Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: widget.height ?? BAR_HEIGHT + additionalBottomPadding,
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
            painter: ConvexPainter(
              top: widget.top ?? CURVE_TOP,
              width: widget.curveSize ?? CONVEX_SIZE,
              height: widget.curveSize ?? CONVEX_SIZE,
              color: widget.backgroundColor ?? Colors.blue,
              gradient: widget.gradient,
              sigma: widget.elevation ?? ELEVATION,
              leftPercent: isFixed()
                  ? const AlwaysStoppedAnimation<double>(0.5)
                  : _animation ?? _initAnimation(),
            ),
          ),
        ),
        _barContent(additionalBottomPadding),
        Positioned.fill(
          top: widget.top,
          bottom: additionalBottomPadding,
          child: FractionallySizedBox(
              widthFactor: 1 / widget.count,
              alignment: Alignment((convexIndex - halfSize) / (halfSize), 0),
              child: GestureDetector(
                child: _newTab(convexIndex, active),
                onTap: () => _onTabClick(convexIndex),
              )),
        ),
      ],
    );
  }

  bool isFixed() => widget.itemBuilder.fixed();

  Widget _barContent(double paddingBottom) {
    List<Widget> children = [];
    // add placeholder Widget
    var curveTabIndex = isFixed() ? widget.count ~/ 2 : _currentIndex;
    for (var i = 0; i < widget.count; i++) {
      if (i == curveTabIndex) {
        children.add(Expanded(child: Container()));
        continue;
      }
      var active = _currentIndex == i;
      Widget child = _newTab(i, active);
      children.add(Expanded(
          child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: child,
        onTap: () => _onTabClick(i),
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

  Widget _newTab(int i, bool active) {
    var child = widget.itemBuilder.build(context, i, active);
    if (widget.chipBuilder != null) {
      child = widget.chipBuilder.build(context, child, i, active);
    }
    return child;
  }

  void _onTabClick(int i) {
    _warpToCurrentIndex(i);
    _tabController?.index = i;
    if (widget.onTap != null) {
      widget.onTap(i);
    }
  }
}

typedef GestureTapIndexCallback = void Function(int index);
typedef CustomTabBuilder = Widget Function(
    BuildContext context, int index, bool active);
