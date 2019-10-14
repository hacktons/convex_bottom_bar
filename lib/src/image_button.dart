import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String text;
  final Color textColor;
  final Color activeTextColor;
  final double fontSize;
  final double drawablePadding;
  final bool isActive;
  final Widget icon;

  ImageButton.assets(
      {Key key,
      @required double width,
      @required double height,
      @required String normalAsset,
      String activeAsset,
      this.text,
      this.textColor,
      this.activeTextColor,
      this.drawablePadding,
      this.fontSize,
      this.onTap,
      @required this.isActive})
      : icon = normalAsset?.length == 0
            ? Container(width: width, height: height)
            : Image.asset(isActive ? activeAsset ?? normalAsset : normalAsset,
                width: width, height: height, fit: BoxFit.cover),
        super(key: key);

  ImageButton.icon(
      {Key key,
      this.text,
      this.textColor,
      this.activeTextColor,
      this.drawablePadding,
      this.fontSize,
      this.onTap,
      @required IconData normalIcon,
      IconData activeIcon,
      @required double size,
      @required this.isActive})
      : icon = normalIcon == null
            ? Container(width: size, height: size)
            : (isActive
                ? Icon(activeIcon ?? normalIcon,
                    size: size, color: activeTextColor)
                : Icon(normalIcon, size: size)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          icon,
          Padding(padding: EdgeInsets.only(bottom: drawablePadding)),
          Text(
            this.text,
            style: TextStyle(
              color: this.isActive ? this.activeTextColor : this.textColor,
              fontSize: fontSize,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
