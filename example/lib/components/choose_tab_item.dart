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

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/choice_value.dart';
import 'radio_item.dart';

class ChooseTabItem extends StatelessWidget {
  const ChooseTabItem(this.tabTypes, this.selectedType, this.onChanged);

  final List<ChoiceValue<List<TabItem>>> tabTypes;
  final ChoiceValue<List<TabItem>> selectedType;
  final ValueChanged<ChoiceValue<List<TabItem>>?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: tabTypes.map<Widget>((ChoiceValue<List<TabItem>> type) {
        return Expanded(
          child: RadioItem<List<TabItem>>(type, selectedType, onChanged),
        );
      }).toList(),
    );
  }
}
