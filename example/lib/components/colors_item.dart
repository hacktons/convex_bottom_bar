import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/named_color.dart';

class ColorsItem extends StatelessWidget {
  const ColorsItem(this.colors, this.selectedColor, this.onChanged);

  final List<NamedColor> colors;
  final Color selectedColor;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colors.map<Widget>((NamedColor namedColor) {
        return RawMaterialButton(
          onPressed: () {
            onChanged(namedColor.color);
          },
          constraints: const BoxConstraints.tightFor(
            width: 32.0,
            height: 32.0,
          ),
          fillColor: namedColor.color,
          shape: CircleBorder(
            side: BorderSide(
              color: namedColor.color == selectedColor
                  ? Colors.black
                  : const Color(0xFFD5D7DA),
              width: 2.0,
            ),
          ),
          child: Semantics(
            value: namedColor.name,
            selected: namedColor.color == selectedColor,
          ),
        );
      }).toList(),
    );
  }
}
