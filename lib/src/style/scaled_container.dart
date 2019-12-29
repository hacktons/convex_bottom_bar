import 'package:flutter/cupertino.dart';

class ScaledContainer extends StatefulWidget {
  final Widget child;
  final Curve curve;

  ScaledContainer({this.child, this.curve});

  @override
  State createState() {
    return _State();
  }
}

class _State extends State<ScaledContainer>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
    )..addListener(() => setState(() {}));
    animation = CurvedAnimation(
      parent: animationController,
      curve: widget.curve,
    );
    animationController.forward();
  }

  @override
  void didUpdateWidget(ScaledContainer oldWidget) {
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
    return ScaleTransition(
      scale: animation,
      child: widget.child,
    );
  }
}
