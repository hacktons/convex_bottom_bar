/*
 *  Copyright 2020 chaobinwu89@gmail.com
 *  
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  
 *      http://www.apache.org/licenses/LICENSE-2.0
 *  
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

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
