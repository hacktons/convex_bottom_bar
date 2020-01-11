import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

abstract class TransitionContainerBuilder {
  final Curve curve;

  TransitionContainerBuilder(this.curve);

  Animation animation(AnimationController controller);

  Widget build(Animation animation);
}

class ScaleBuilder extends TransitionContainerBuilder {
  Widget child;

  @override
  Animation animation(AnimationController controller) {
    return CurvedAnimation(parent: controller, curve: curve);
  }

  @override
  Widget build(Animation animation) {
    return ScaleTransition(scale: animation, child: child);
  }

  ScaleBuilder({Curve curve, this.child}) : super(curve);
}

class SlideBuilder extends TransitionContainerBuilder {
  Widget child;

  SlideBuilder({Curve curve, this.child}) : super(curve);

  @override
  Widget build(Animation animation) {
    return SlideTransition(position: animation, child: child);
  }

  @override
  Animation animation(AnimationController controller) {
    return Tween<Offset>(
      begin: const Offset(0.0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: curve));
  }
}

/// This flip animation is origin from [https://github.com/deven98/flip_box_bar/blob/master/lib/src/flip_box.dart]
/// UX => ![](https://cdn.dribbble.com/users/1094383/screenshots/4811135/800_5.gif)
class FlipBuilder extends TransitionContainerBuilder {
  final Widget topChild;
  final Widget bottomChild;
  final double height;

  FlipBuilder(this.height, {Curve curve, this.topChild, this.bottomChild})
      : super(curve);

  @override
  Animation animation(AnimationController controller) {
    return Tween(begin: 0.0, end: pi / 2).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );
  }

  @override
  Widget build(Animation animation) {
    return Container(
      child: Stack(
        children: <Widget>[
          Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..translate(0.0, (cos(animation.value) * (height / 2)),
                  ((height / 2) * sin(animation.value)))
              ..rotateX(-(pi / 2) + animation.value),
            child: Container(
              child: Center(child: bottomChild),
            ),
          ),
          animation.value < (85 * pi / 180)
              ? Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..translate(
                      0.0,
                      -(height / 2) * sin(animation.value),
                      ((height / 2) * cos(animation.value)),
                    )
                    ..rotateX(animation.value),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Center(child: topChild),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
