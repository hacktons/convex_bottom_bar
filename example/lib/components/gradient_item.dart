import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientItem extends StatelessWidget {
  const GradientItem(this.colors, this.selectedColor, this.onChanged);

  final List<Gradient> colors;
  final Gradient selectedColor;
  final ValueChanged<Gradient> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colors.map<Widget>((Gradient namedColor) {
        return GestureDetector(
          onTap: () => onChanged(namedColor),
          child: Container(
            height: 40,
            width: 80,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: namedColor == selectedColor
                      ? Colors.black
                      : const Color(0xFFD5D7DA),
                  width: 2),
              gradient: namedColor,
              color: namedColor != null ? Colors.grey : null,
            ),
            child: namedColor == null ? Center(child: Text('clear')) : null,
          ),
        );
      }).toList(),
    );
  }
}
