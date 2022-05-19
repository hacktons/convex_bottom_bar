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

class GradientItem extends StatelessWidget {
  const GradientItem(this.colors, this.selectedColor, this.onChanged);

  final List<Gradient?> colors;
  final Gradient? selectedColor;
  final ValueChanged<Gradient?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: colors.map<Widget>((Gradient? namedColor) {
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
