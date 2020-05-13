import 'package:flutter/widgets.dart';

import 'interface.dart';

/// Simple builder for [ConvexAppBar.builder]
class SimpleBuilder extends DelegateBuilder {
  @override
  Widget build(BuildContext context, int index, bool active) {
    // TODO: implement build
    return null;
  }
}

typedef TabWidgetFunc = Widget Function(
    BuildContext context, int index, bool active);
