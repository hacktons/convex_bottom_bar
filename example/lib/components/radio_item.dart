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

import '../model/choice_value.dart';

// copy of _RadioItem from flutter gallery
class RadioItem<T> extends StatelessWidget {
  const RadioItem(this.value, this.groupValue, this.onChanged);

  final ChoiceValue<T> value;
  final ChoiceValue<T> groupValue;
  final ValueChanged<ChoiceValue<T>?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0,
      padding: const EdgeInsetsDirectional.only(start: 16.0),
      alignment: AlignmentDirectional.centerStart,
      child: MergeSemantics(
        child: Row(
          children: <Widget>[
            Radio<ChoiceValue<T>>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
            Expanded(
              child: Semantics(
                container: true,
                button: true,
                label: value.label,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (onChanged != null) {
                      onChanged!(value);
                    }
                  },
                  child: Text(value.title),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
