/*
 *  Copyright 2020 chaobinwu89@gmail.com
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'transition_container_builder.dart';

/// Add controller with provided transition api, such as [SlideTransition], [ScaleTransition].
class TransitionContainer extends StatefulWidget {
  /// Build transition.
  final TransitionContainerBuilder builder;

  /// Transition duration.
  final Duration duration;

  /// Control whether the animation should be skipped when widget change.
  final bool disableAnimateWhenUpdate;

  /// Create transition with builder.
  TransitionContainer(
      {@required this.builder, this.duration, this.disableAnimateWhenUpdate})
      : assert(builder != null);

  /// Wrap a widget with scale transition.
  TransitionContainer.scale(
      {Widget child, Curve curve, this.duration, this.disableAnimateWhenUpdate})
      : builder = ScaleBuilder(curve: curve, child: child);

  /// Wrap a widget with slide transition.
  TransitionContainer.slide({
    Widget child,
    Curve curve,
    this.duration,
    bool reverse = false,
    this.disableAnimateWhenUpdate,
  }) : builder = SlideBuilder(curve: curve, child: child, reverse: reverse);

  /// Wrap a widget with flip transition.
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
