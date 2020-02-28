import 'package:flutter/cupertino.dart';

/// Tab item used for [ConvexAppBar].
class TabItem<T> {
  /// Tab text.
  final String title;

  /// IconData or Image.
  ///
  /// ![](https://github.com/hacktons/convex_bottom_bar/raw/master/doc/appbar-image.gif)
  final T icon;

  /// Optional if not provided ,[icon] is used.
  final T activeIcon;

  /// Whether icon should blend with color.
  final bool blend;

  /// Create item
  const TabItem({
    this.title,
    @required this.icon,
    this.activeIcon,
    bool isIconBlend,
  })  : assert(icon is IconData || icon is Widget,
            "TabItem only support IconData and Widget"),
        blend = isIconBlend ?? (icon is IconData);
}
