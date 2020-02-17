import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'transition_container_builder.dart';

/// Add controller with provided transition api, such as [SlideTransition], [ScaleTransition]
class TransitionContainer extends StatefulWidget {
  final TransitionContainerBuilder builder;
  final Duration duration;
  final bool disableAnimateWhenUpdate;

  TransitionContainer(
      {this.builder, this.duration, this.disableAnimateWhenUpdate})
      : assert(builder != null);

  TransitionContainer.scale(
      {Widget child, Curve curve, this.duration, this.disableAnimateWhenUpdate})
      : builder = ScaleBuilder(curve: curve, child: child);

  TransitionContainer.slide({
    Widget child,
    Curve curve,
    this.duration,
    bool reverse = false,
    this.disableAnimateWhenUpdate,
  }) : builder = SlideBuilder(curve: curve, child: child, reverse: reverse);

  TransitionContainer.flip({
    Widget topChild,
    Widget bottomChild,
    Curve curve,
    double height,
    this.duration,
    this.disableAnimateWhenUpdate,
  }) : builder = FlipBuilder(
          height,
          curve: curve,
          topChild: topChild,
          bottomChild: bottomChild,
        );

  @override
  _State createState() {
    return _State();
  }
}

class _State extends State<TransitionContainer> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
    _setAnimation();
  }

  void _setAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: widget.duration ?? Duration(milliseconds: 150),
    )..addListener(() => setState(() {}));
    animationController.forward();
    animation = widget.builder.animation(animationController);
  }

  @override
  void didUpdateWidget(TransitionContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.builder.runtimeType != widget.builder.runtimeType) {
      animationController?.dispose();
      _setAnimation();
    } else {
      if (widget.disableAnimateWhenUpdate == true) {
        return;
      }
      animationController?.reset();
      animationController?.forward();
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.build(animation);
  }
}
