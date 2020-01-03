import 'package:flutter/cupertino.dart';

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
