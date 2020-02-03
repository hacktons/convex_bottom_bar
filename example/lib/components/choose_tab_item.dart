import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/choice_value.dart';
import 'radio_item.dart';

class ChooseTabItem extends StatelessWidget {
  const ChooseTabItem(this.tabTypes, this.selectedType, this.onChanged);

  final List<ChoiceValue<List<TabItem>>> tabTypes;
  final ChoiceValue<List<TabItem>> selectedType;
  final ValueChanged<ChoiceValue<List<TabItem>>> onChanged;

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
