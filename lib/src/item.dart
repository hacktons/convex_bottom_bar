import 'package:flutter/cupertino.dart';

class TabItem<T> {
  final String title;

  /// IconData or Image
  final T icon;

  /// Optional if not provided ,[icon] is used
  final T activeIcon;

  const TabItem({
    this.title,
    @required this.icon,
    this.activeIcon,
  }) : assert(icon is IconData || icon is Widget,
            "TabItem only support IconData and Widget");
}
