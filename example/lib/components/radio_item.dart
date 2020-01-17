import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/choice_value.dart';

// copy of _RadioItem from flutter gallery
class RadioItem<T> extends StatelessWidget {
  const RadioItem(this.value, this.groupValue, this.onChanged);

  final ChoiceValue<T> value;
  final ChoiceValue<T> groupValue;
  final ValueChanged<ChoiceValue<T>> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
                      onChanged(value);
                    }
                  },
                  child: Text(
                    value.title,
                    style: theme.textTheme.subhead,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
