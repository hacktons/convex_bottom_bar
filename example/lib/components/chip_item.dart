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

import '../model/badge.dart';

class ChipItem extends StatelessWidget {
  const ChipItem(this.chips, this.selectedChip, this.onChanged);

  final List<Badge?> chips;
  final Badge? selectedChip;
  final ValueChanged<Badge?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: chips.map<Widget>((Badge? chip) {
        return GestureDetector(
          onTap: () => onChanged(chip),
          child: Container(
            height: 40,
            width: 80,
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                  color: chip == selectedChip
                      ? Colors.black
                      : const Color(0xFFD5D7DA),
                  width: 2),
            ),
            child: chip == null
                ? Center(child: Text('clear'))
                : Center(
                    child: Material(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(chip.borderRadius ?? 20),
                      ),
                      type: MaterialType.card,
                      color: chip.badgeColor ?? Colors.redAccent,
                      child: Padding(
                        padding:
                            chip.padding ?? EdgeInsets.only(left: 4, right: 4),
                        child: Text(
                          chip.text,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ),
        );
      }).toList(),
    );
  }
}
