import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'chip_builder.dart';
import 'interface.dart';
import 'item.dart';
import 'painter.dart';
import 'stack.dart' as extend;
import 'style/fixed_circle_tab_style.dart';
import 'style/fixed_tab_style.dart';
import 'style/react_circle_tab_style.dart';
import 'style/react_tab_style.dart';
import 'style/styles.dart';

/// Default size of the curve line.
const double CONVEX_SIZE = 80;

/// Default height of the AppBar.
const double BAR_HEIGHT = 50;

/// Default distance that the child's top edge is inset from the top of the stack.
const double CURVE_TOP = -25;

/// Default size for active tab.
const double ACTION_LAYOUT_SIZE = 60;

/// Default size for active icon in tab.
const double ACTION_INNER_BUTTON_SIZE = 40;

/// Default elevation of [ConvexAppBar].
const double ELEVATION = 2;

/// Tab styles.
enum TabStyle {
  /// Convex shape fixed center, see [FixedTabStyle].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-fixed.gif)
  fixed,

  /// Convex shape is fixed center with circle, see [FixedCircleTabStyle].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-fixed-circle.gif)
  fixedCircle,

  /// Convex shape is moved after selection, see [ReactTabStyle].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-react.gif)
  react,

  /// Convex shape is moved with circle after selection, see [ReactCircleTabStyle].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-react-circle.gif)
  reactCircle,

  /// Tab icon, text animated with pop transition.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-textIn.gif)
  textIn,

  /// Similar to [TabStyle.textIn], text first.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-titled.gif)
  titled,

  /// Tab item is flipped when selected, does not support [flutter web].
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-flip.gif)
  flip,

  /// User defined style
  custom,
}

/// Online example can be found at http://hacktons.cn/convex_bottom_bar.
///
/// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-theming.png)
class ConvexAppBar extends StatefulWidget {
  /// Tab item builder.
  final DelegateBuilder itemBuilder;

  /// Badge chip builder.
  final ChipBuilder chipBuilder;

  /// Tab Click handler.
  final GestureTapIndexCallback onTap;

  /// Tab controller to work with [TabBarView] or [PageView].
  final TabController controller;

  /// Color of the AppBar.
  final Color backgroundColor;

  /// If provided, backgroundColor for tab app will be ignored.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-gradient.gif)
  final Gradient gradient;

  /// The initial active index, you can config initialIndex of [TabController] if work with [TabBarView] or [PageView].
  final int initialActiveIndex;

  /// Tab count.
  final int count;

  /// Height of the AppBar.
  final double height;

  /// Size of the curve line.
  final double curveSize;

  /// The distance that the [actionButton] top edge is inset from the top of the AppBar.
  final double top;

  /// Elevation for the bar top edge.
  final double elevation;

  /// The curve to use in the forward direction. Only works when tab style is not fixed.
  final Curve curve;

  /// Construct a new appbar with internal style.
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
  ///
  /// You can also define a custom chipBuilder class.
  /// ```dart
  /// class _ChipBuilder extends ChipBuilder {
  ///  @override
  ///  Widget build(BuildContext context, Widget child, int index, bool active) {
  ///    return Stack(
  ///      alignment: Alignment.center,
  ///      children: <Widget>[
  ///        child,
  ///        Positioned.fill(
  ///          child: Align(
  ///            alignment: Alignment.topRight,
  ///            child: Container(
  ///              margin: EdgeInsets.only(top: 10, right: 10),
  ///              padding: EdgeInsets.only(left: 4, right: 4),
  ///              child: Icon(Icons.access_alarm, color: Colors.redAccent),
  ///            ),
  ///          ),
  ///        )
  ///      ],
  ///    );
  ///    ;
  ///  }
  /// }
  ///```
  /// See also:
  ///
  ///  * [ConvexAppBar.builder], define a custom tab style by implement a [DelegateBuilder].
  ///  * [ConvexAppBar.badge], construct a new appbar with styled badge.
  ConvexAppBar({
    Key key,
    @required List<TabItem> items,
    int initialActiveIndex,
    GestureTapIndexCallback onTap,
    TabController controller,
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
          controller: controller,
          backgroundColor: backgroundColor ?? Colors.blue,
          count: items.length,
          initialActiveIndex: initialActiveIndex,
          gradient: gradient,
          height: height,
          curveSize: curveSize,
          top: top,
          elevation: elevation,
          curve: curve ?? Curves.easeInOut,
          chipBuilder: chipBuilder,
        );

  /// Define a custom tab style by implement a [DelegateBuilder].
  ///
  /// ```dart
  /// ConvexAppBar(
  ///   count: 5,
  ///   itemBuilder: Builder(),
  /// )
  ///
  /// class Builder extends DelegateBuilder {
  ///   @override
  ///   Widget build(BuildContext context, int index, bool active) {
  ///     return Text('TAB $index');
  ///   }
  /// }
  /// ```
  const ConvexAppBar.builder({
    Key key,
    @required this.itemBuilder,
    @required this.count,
    this.initialActiveIndex,
    this.onTap,
    this.controller,
    this.backgroundColor,
    this.gradient,
    this.height,
    this.curveSize,
    this.top,
    this.elevation,
    this.curve = Curves.easeInOut,
    this.chipBuilder,
  })  : assert(top == null || top <= 0, 'top should be negative'),
        assert(itemBuilder != null, 'provide custom buidler'),
        assert(initialActiveIndex == null || initialActiveIndex < count,
            'initial index should < $count'),
        super(key: key);

  /// Construct a new appbar with badge.
  ///
  /// {@animation 1010 598 https://github.com/hacktons/convex_bottom_bar/raw/master/doc/badge-demo.mp4}
  ///
  /// [badge] is map with tab items, the value of entry can be either [String],
  /// [IconData], [Color] or [Widget].
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
    TabController controller,
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
      controller: controller,
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
  ConvexAppBarState createState() {
    return ConvexAppBarState();
  }
}

/// State of [ConvexAppBar].
class ConvexAppBarState extends State<ConvexAppBar>
    with TickerProviderStateMixin {
  int _currentIndex;
  Animation<double> _animation;
  AnimationController _controller;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    if (!isFixed()) {
      _initAnimation();
    }
  }

  void _handleTabControllerAnimationTick({bool force = false}) {
    if (!force && _tabController.indexIsChanging) {
      return;
    }
    if (_tabController.index != _currentIndex) {
      animateTo(_tabController.index);
    }
  }

  /// change active tab index; can be used with [PageView].
  Future<void> animateTo(int index) async {
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
        widget.controller ?? DefaultTabController.of(context);
    _tabController?.removeListener(_handleTabControllerAnimationTick);
    _tabController = newController;
    _tabController?.addListener(_handleTabControllerAnimationTick);
    _currentIndex = widget.initialActiveIndex ?? _tabController?.index ?? 0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateTabController();

    /// When both ConvexAppBar and TabController are configured with initial index, there can be conflict;
    /// We use ConvexAppBar's value;
    if (widget.initialActiveIndex != null &&
        _tabController != null &&
        widget.initialActiveIndex != _tabController.index) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _tabController.index = _currentIndex;
      });
    }
  }

  @override
  void didUpdateWidget(ConvexAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _updateTabController();
    }
  }

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    final double additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    final convexIndex = isFixed() ? (widget.count ~/ 2) : _currentIndex;
    final active = isFixed() ? convexIndex == _currentIndex : true;

    final height = widget.height ?? BAR_HEIGHT + additionalBottomPadding;
    final width = MediaQuery.of(context).size.width;
    var percent = isFixed()
        ? const AlwaysStoppedAnimation<double>(0.5)
        : _animation ?? _initAnimation();
    var factor = 1 / widget.count;
    var offset = FractionalOffset(
      widget.count > 1 ? 1 / (widget.count - 1) * convexIndex : 0.0,
      0,
    );
    return extend.Stack(
      overflow: Overflow.visible,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: height,
          width: width,
          child: CustomPaint(
            painter: ConvexPainter(
              top: widget.top ?? CURVE_TOP,
              width: widget.curveSize ?? CONVEX_SIZE,
              height: widget.curveSize ?? CONVEX_SIZE,
              color: widget.backgroundColor ?? Colors.blue,
              gradient: widget.gradient,
              sigma: widget.elevation ?? ELEVATION,
              leftPercent: percent,
            ),
          ),
        ),
        _barContent(height, additionalBottomPadding, convexIndex),
        Positioned.fill(
          top: widget.top ?? CURVE_TOP,
          bottom: additionalBottomPadding,
          child: FractionallySizedBox(
              widthFactor: factor,
              alignment: offset,
              child: GestureDetector(
                child: _newTab(convexIndex, active),
                onTap: () => _onTabClick(convexIndex),
              )),
        ),
      ],
    );
  }

  /// Whether the tab shape are fixed or not.
  bool isFixed() => widget.itemBuilder.fixed();

  Widget _barContent(double height, double paddingBottom, int curveTabIndex) {
    List<Widget> children = [];
    for (var i = 0; i < widget.count; i++) {
      if (i == curveTabIndex) {
        children.add(Expanded(child: Container()));
        continue;
      }
      var active = _currentIndex == i;
      children.add(Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: _newTab(i, active),
          onTap: () => _onTabClick(i),
        ),
      ));
    }

    return Container(
      height: height,
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
    animateTo(i);
    _tabController?.index = i;
    if (widget.onTap != null) {
      widget.onTap(i);
    }
  }
}

/// Hook for internal tab style. Unlike the [ConvexAppBar.builder], you may want to
/// update the tab style without define a new tab style.
///
/// Warning:
/// This hook is limited, and can lead to `overflow broken` if the size you provide
/// does no match with internal style.
class StyleProvider extends InheritedWidget {
  /// Style configuration
  final StyleHook style;

  /// Provide style to provider, [ConvexAppBar] will bind to the provided style.
  /// See also:
  ///
  ///  * [ConvexAppBar]
  ///  * [StyleHook]
  StyleProvider({Key key, @required this.style, @required Widget child})
      : assert(style != null),
        assert(child != null),
        super(key: key, child: child);

  /// Get instance of style provider
  static StyleProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleProvider>();
  }

  @override
  bool updateShouldNotify(StyleProvider oldWidget) {
    return style.activeIconMargin != oldWidget.style.activeIconMargin ||
        style.activeIconSize != oldWidget.style.activeIconSize ||
        style.iconSize != oldWidget.style.iconSize;
  }
}
