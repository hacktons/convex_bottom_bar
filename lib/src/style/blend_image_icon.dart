import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// decorate the provided [Image] or [IconData]
class BlendImageIcon<T> extends StatelessWidget {
  const BlendImageIcon(this.image, {Key key, this.color, this.size})
      : assert(image is Widget || image is IconData,
            'image must be IconData or Widget'),
        super(key: key);

  final Color color;
  final T image;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (image is Widget) {
      var s = size ?? IconTheme.of(context).size;
      // flutter web do not support shader mask. (flutter v1.12.x)
      var showRawImage = kIsWeb || color == null;
      if (showRawImage) {
        return SizedBox(
          width: s,
          height: s,
          child: image as Widget,
        );
      }
      return SizedBox(
        width: s,
        height: s,
        child: ShaderMask(
          child: image as Widget,
          shaderCallback: (Rect bounds) {
            return LinearGradient(colors: [color, color]).createShader(bounds);
          },
          blendMode: BlendMode.srcIn,
        ),
      );
    }
    return Icon(image as IconData, size: size, color: color);
  }
}
