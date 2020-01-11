import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'transition_container_builder.dart';

/// Add controller with provided transition api, such as [SlideTransition], [ScaleTransition]
class TransitionContainer extends StatefulWidget {
  final TransitionContainerBuilder builder;
  final Duration duration;

  TransitionContainer({this.builder, this.duration}) : assert(builder != null);

  TransitionContainer.scale({Widget child, Curve curve, this.duration})
      : builder = ScaleBuilder(curve: curve, child: child);

  TransitionContainer.slide({Widget child, Curve curve, this.duration})
      : builder = SlideBuilder(curve: curve, child: child);

  TransitionContainer.flip({
    Widget topChild,
    Widget bottomChild,
    Curve curve,
    double height,
    this.duration,
  }) : builder = FlipBuilder(
          height,
          curve: curve,
          topChild: topChild,
          bottomChild: bottomChild,
        );

  @override
  State createState() {
    return _State();
  }
}

class _State extends State<TransitionContainer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();
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
    animationController.reset();
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder.build(animation);
  }
}
