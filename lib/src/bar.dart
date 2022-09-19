/*
 *  Copyright 2020 Chaobin Wu <chaobinwu89@gmail.com>
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

import 'dart:math' as math;

import 'package:flutter/material.dart';

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
  final ChipBuilder? chipBuilder;

  /// Tab Click handler.
  final GestureTapIndexCallback? onTap;

  /// Tab event notifier, can be used to block tap event.
  final TapNotifier? onTapNotify;

  /// Tab controller to work with [TabBarView] or [PageView].
  final TabController? controller;

  /// Color of the AppBar.
  final Color? backgroundColor;

  /// Color of the elevation.
  final Color? shadowColor;

  /// Draw the background with topLeft and topRight corner; Only work work with fixed style
  ///
  /// ![corner image](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-corner.png)
  final double? cornerRadius;

  /// If provided, backgroundColor for tab app will be ignored.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-gradient.gif)
  final Gradient? gradient;

  /// The initial active index, you can config initialIndex of [TabController] if work with [TabBarView] or [PageView].
  final int? initialActiveIndex;

  /// Disable access of DefaultTabController to avoid unexpected conflict.
  final bool disableDefaultTabController;

  /// Tab count.
  final int count;

  /// Height of the AppBar.
  final double? height;

  /// Size of the curve line.
  final double? curveSize;

  /// The distance that the [actionButton] top edge is inset from the top of the AppBar.
  final double? top;

  /// Elevation for the bar top edge.
  final double? elevation;

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
    Key? key,
    required List<TabItem> items,
    int? initialActiveIndex,
    bool? disableDefaultTabController,
    GestureTapIndexCallback? onTap,
    TapNotifier? onTabNotify,
    TabController? controller,
    Color? color,
    Color? activeColor,
    Color? backgroundColor,
    Color? shadowColor,
    Gradient? gradient,
    double? height,
    double? curveSize,
    double? top,
    double? elevation,
    double? cornerRadius,
    TabStyle? style,
    Curve? curve,
    ChipBuilder? chipBuilder,
  }) : this.builder(
          key: key,
          itemBuilder: supportedStyle(
            style ?? TabStyle.reactCircle,
            items: items,
            color: color ?? Colors.white60,
            activeColor: activeColor ?? Colors.white,
            backgroundColor: backgroundColor ?? Colors.blue,
            curve: curve ?? Curves.easeInOut,
          ),
          onTap: onTap,
          onTapNotify: onTabNotify,
          controller: controller,
          backgroundColor: backgroundColor,
          shadowColor: shadowColor,
          count: items.length,
          initialActiveIndex: initialActiveIndex,
          disableDefaultTabController: disableDefaultTabController ?? false,
          gradient: gradient,
          height: height,
          curveSize: curveSize,
          top: top,
          elevation: elevation,
          cornerRadius: cornerRadius,
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
    Key? key,
    required this.itemBuilder,
    required this.count,
    this.initialActiveIndex,
    this.disableDefaultTabController = false,
    this.onTap,
    this.onTapNotify,
    this.controller,
    this.backgroundColor,
    this.shadowColor,
    this.gradient,
    this.height,
    this.curveSize,
    this.top,
    this.elevation,
    this.cornerRadius,
    this.curve = Curves.easeInOut,
    this.chipBuilder,
  })  : assert(top == null || top <= 0, 'top should be negative'),
        assert(initialActiveIndex == null || initialActiveIndex < count,
            'initial index should < $count'),
        assert(cornerRadius == null || cornerRadius >= 0,
            'cornerRadius must >= 0'),
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
    Key? key,
    // config for badge
    Color? badgeTextColor,
    Color? badgeColor,
    EdgeInsets? badgePadding,
    EdgeInsets? badgeMargin,
    double? badgeBorderRadius,
    // parameter for appbar
    required List<TabItem> items,
    int? initialActiveIndex,
    bool? disableDefaultTabController,
    GestureTapIndexCallback? onTap,
    TapNotifier? onTabNotify,
    TabController? controller,
    Color? color,
    Color? activeColor,
    Color? backgroundColor,
    Color? shadowColor,
    Gradient? gradient,
    double? height,
    double? curveSize,
    double? top,
    double? elevation,
    double? cornerRadius,
    TabStyle? style,
    Curve? curve,
  }) {
    DefaultChipBuilder? chipBuilder;
    if (badge.isNotEmpty) {
      chipBuilder = DefaultChipBuilder(
        badge,
        textColor: badgeTextColor ?? Colors.white,
        badgeColor: badgeColor ?? Colors.redAccent,
        padding: badgePadding ?? EdgeInsets.only(left: 4, right: 4),
        margin: badgeMargin ?? EdgeInsets.only(top: 10, right: 10),
        borderRadius: badgeBorderRadius ?? 20,
      );
    }
    return ConvexAppBar(
      key: key,
      items: items,
      initialActiveIndex: initialActiveIndex,
      disableDefaultTabController: disableDefaultTabController ?? false,
      onTap: onTap,
      onTabNotify: onTabNotify,
      controller: controller,
      color: color,
      activeColor: activeColor,
      backgroundColor: backgroundColor,
      shadowColor: shadowColor,
      gradient: gradient,
      height: height,
      curveSize: curveSize,
      top: top,
      elevation: elevation,
      cornerRadius: cornerRadius,
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
  int? _currentIndex;
  int? get currentIndex => _currentIndex;
  int _warpUnderwayCount = 0;
  Animation<double>? _animation;
  AnimationController? _animationController;
  TabController? _controller;

  int _previousTimestamp = 0;
  static const _TRANSITION_DURATION = 150;

  @override
  void initState() {
    if (widget.cornerRadius != null && widget.cornerRadius! > 0 && !isFixed()) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('ConvexAppBar is configured with cornerRadius'),
        ErrorDescription(
            'Currently the corner only work for fixed style, if you are using '
            'other styles, the convex shape can be broken on the first and last tab item '),
        ErrorHint(
            'You should use TabStyle.fixed or TabStyle.fixedCircle to make the'
            ' background display with topLeft/topRight corner'),
      ]);
    }
    _resetState();
    super.initState();
  }

  void _handleTabControllerAnimationTick() {
    if (_warpUnderwayCount > 0 ||
        _controller == null ||
        !_controller!.indexIsChanging) {
      return;
    }
    if (_controller!.index != _currentIndex) {
      _warpToCurrentIndex();
    }
  }

  Future<void> _warpToCurrentIndex() async {
    if (!mounted) return Future<void>.value();
    final c = _controller;
    if (c == null) {
      return;
    }
    if (_blockEvent(c.index)) return;
    final previousIndex = c.previousIndex;
    final index = c.index;
    // Counter to avoid repeat calls to animateTo in the middle of a transition.
    _warpUnderwayCount += 1;
    await animateTo(index, from: previousIndex);
    _warpUnderwayCount -= 1;
    return Future<void>.value();
  }

  /// change active tab index; can be used with [PageView].
  Future<void> animateTo(int index, {int? from}) async {
    var gap = DateTime.now().millisecondsSinceEpoch - _previousTimestamp;
    _updateAnimation(
      from: from ?? _currentIndex,
      to: index,
      duration: Duration(
          milliseconds: gap < _TRANSITION_DURATION ? 0 : _TRANSITION_DURATION),
    );
    // ignore: unawaited_futures
    _animationController?.forward();
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
    _previousTimestamp = DateTime.now().millisecondsSinceEpoch;
  }

  Animation<double> _updateAnimation(
      {int? from,
      int? to,
      Duration duration = const Duration(milliseconds: _TRANSITION_DURATION)}) {
    if (from != null && (from == to) && _animation != null) {
      return _animation!;
    }
    from ??= _controller?.index ?? widget.initialActiveIndex ?? 0;
    to ??= from;
    final lower = (2 * from + 1) / (2 * widget.count);
    final upper = (2 * to + 1) / (2 * widget.count);
    _animationController?.dispose();
    final controller = AnimationController(duration: duration, vsync: this);
    final curve = CurvedAnimation(
      parent: controller,
      curve: widget.curve,
    );
    _animationController = controller;
    return _animation = Tween(begin: lower, end: upper).animate(curve);
  }

  @override
  void dispose() {
    _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
    _controller = null;

    _animationController?.dispose();
    super.dispose();
  }

  TabController? get _currentControllerRef {
    if (widget.disableDefaultTabController == true) {
      return widget.controller;
    }
    return widget.controller ?? DefaultTabController.of(context);
  }

  void _updateTabController() {
    final newController = _currentControllerRef;
    assert(() {
      if (newController != null &&
          widget.controller == null &&
          widget.initialActiveIndex != null) {
        throw FlutterError(
            'ConvexAppBar.initialActiveIndex is not allowed when working with TabController.\n'
            'Please setup through TabController.initialIndex, or disable DefaultTabController by #disableDefaultTabController');
      }
      return true;
    }());
    if (newController == _controller) return;
    _controller?.animation?.removeListener(_handleTabControllerAnimationTick);
    _controller = newController;
    _controller?.animation?.addListener(_handleTabControllerAnimationTick);
  }

  void _resetState() {
    var index = _controller?.index ?? widget.initialActiveIndex;
    // when both initialActiveIndex and controller are not configured
    _currentIndex = index ?? 0;

    if (!isFixed() && _controller != null) {
      // when controller is not defined, the default index can rollback to 0
      // https://github.com/hacktons/convex_bottom_bar/issues/67
      _updateAnimation();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller != _currentControllerRef) {
      _updateTabController();
      _resetState();
    }
  }

  @override
  void didUpdateWidget(ConvexAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller ||
        widget.count != oldWidget.count) {
      _updateTabController();
      _resetState();
    }
  }

  @override
  Widget build(BuildContext context) {
    // take care of iPhoneX' safe area at bottom edge
    final additionalBottomPadding =
        math.max(MediaQuery.of(context).padding.bottom, 0.0);
    final convexIndex = isFixed() ? (widget.count ~/ 2) : _currentIndex;
    final active = isFixed() ? convexIndex == _currentIndex : true;

    final height = (widget.height ?? BAR_HEIGHT) + additionalBottomPadding;
    final width = MediaQuery.of(context).size.width;
    var percent = isFixed()
        ? const AlwaysStoppedAnimation<double>(0.5)
        : _animation ?? _updateAnimation();
    var factor = 1 / widget.count;
    var textDirection = Directionality.of(context);
    var dx = convexIndex! / (widget.count - 1);
    if (textDirection == TextDirection.rtl) {
      dx = 1 - dx;
    }

    var offset = FractionalOffset(widget.count > 1 ? dx : 0.0, 0);
    return extend.Stack(
      clipBehavior: Clip.none,
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
              shadowColor: widget.shadowColor ?? Colors.black38,
              gradient: widget.gradient,
              sigma: widget.elevation ?? ELEVATION,
              leftPercent: percent,
              textDirection: textDirection,
              cornerRadius: widget.cornerRadius,
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
                onTap: () => _onTabClick(convexIndex),
                child: _newTab(convexIndex, active),
              )),
        ),
      ],
    );
  }

  /// Whether the tab shape are fixed or not.
  bool isFixed() => widget.itemBuilder.fixed();

  Widget _barContent(double height, double paddingBottom, int curveTabIndex) {
    var children = <Widget>[];
    for (var i = 0; i < widget.count; i++) {
      if (i == curveTabIndex) {
        children.add(Expanded(child: Container()));
        continue;
      }
      var active = _currentIndex == i;
      children.add(Expanded(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _onTabClick(i),
          child: _newTab(i, active),
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
    final child = widget.itemBuilder.build(context, i, active);
    return widget.chipBuilder?.build(context, child, i, active) ?? child;
  }

  bool _blockEvent(int i) {
    if (widget.onTapNotify != null && !widget.onTapNotify!(i)) {
      debugPrint('tap event block by ${widget.onTapNotify}');
      return true;
    }
    return false;
  }

  void _onTabClick(int i) {
    if (_blockEvent(i)) return;
    if (_controller == null) {
      animateTo(i);
    } else {
      // animation listener [_handleTabControllerAnimationTick] will drive the
      // internal animateTo() via [_warpToCurrentIndex].
      _controller!.animateTo(i);
    }
    widget.onTap?.call(i);
  }

  /// Used to simulate tab event on tab item; This will notify [ConvexAppBar.onTap];
  ///
  /// Also see:
  /// * [animateTo]
  void tap(int index) {
    _onTabClick(index);
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
  StyleProvider({Key? key, required this.style, required Widget child})
      : super(key: key, child: child);

  /// Get instance of style provider, can be null if you're not providing one.
  static StyleProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<StyleProvider>();
  }

  @override
  bool updateShouldNotify(StyleProvider oldWidget) {
    return style.activeIconMargin != oldWidget.style.activeIconMargin ||
        style.activeIconSize != oldWidget.style.activeIconSize ||
        style.iconSize != oldWidget.style.iconSize;
  }
}
