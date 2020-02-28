import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  const Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      height: 48.0,
      padding: const EdgeInsetsDirectional.only(start: 56.0),
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        text,
        style: theme.textTheme.body1.copyWith(
          color: theme.primaryColor,
        ),
      ),
    );
  }
}
