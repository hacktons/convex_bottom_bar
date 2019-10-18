import 'package:flutter/cupertino.dart';

class TabItem {
  final String title;
  final IconData icon;

  /// Optional if not provided ,[icon] is used
  final IconData activeIcon;

  const TabItem({
    this.title,
    @required this.icon,
    this.activeIcon,
  });
}
