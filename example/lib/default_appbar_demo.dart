import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'components/colors_item.dart';
import 'components/gradient_item.dart';
import 'components/heading.dart';
import 'components/radio_item.dart';
import 'data.dart';
import 'model/choice_value.dart';

class DefaultAppBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<DefaultAppBarDemo> {
  static const INDEX_PUBLISH = 2;
  static const kStyles = [
    ChoiceValue<TabStyle>(
      title: 'TabStyle.react',
      label: 'Appbar use react style',
      value: TabStyle.react,
    ),
    ChoiceValue<TabStyle>(
      title: 'TabStyle.reactCircle',
      label: 'Appbar use reactCircle style',
      value: TabStyle.reactCircle,
    ),
    ChoiceValue<TabStyle>(
      title: kIsWeb
          ? 'TabStyle.flip (Flutter Web is not supported)'
          : 'TabStyle.flip',
      label: 'Appbar use fixed style',
      value: TabStyle.flip,
    ),
    ChoiceValue<TabStyle>(
      title: 'TabStyle.textIn',
      label: 'Appbar use pop style',
      value: TabStyle.textIn,
    ),
    ChoiceValue<TabStyle>(
      title: 'TabStyle.titled',
      label: 'Appbar use titled style',
      value: TabStyle.titled,
    ),
    ChoiceValue<TabStyle>(
      title: 'TabStyle.fixed',
      label: 'Appbar use fixed style',
      value: TabStyle.fixed,
    ),
    ChoiceValue<TabStyle>(
      title: 'TabStyle.fixedCircle',
      label: 'Appbar use fixedCircle style',
      value: TabStyle.fixedCircle,
    ),
  ];

  static final kTabItem = [
    ChoiceValue<List<TabItem>>(
      title: 'Icon Tab',
      label: 'Appbar use Icon as Tab',
      value: Data.items(image: false),
    ),
    ChoiceValue<List<TabItem>>(
      title: 'Image Tab',
      label: 'Appbar use Image as Tab',
      value: Data.items(image: true),
    ),
  ];
  var _tabItems = kTabItem.first;

  ChoiceValue<TabStyle> _style = kStyles.first;
  ChoiceValue<Curve> _curve = Data.curves.first;
  Color _babColor = Data.namedColors.first.color;
  Gradient _gradient = Data.gradients.first;

  @override
  Widget build(BuildContext context) {
    var options = <Widget>[
      const Heading('Appbar Color'),
      ColorsItem(Data.namedColors, _babColor, _onBabColorChanged),
      const Divider(),
      const Heading('Background Gradient'),
      GradientItem(Data.gradients, _gradient, _onGradientChanged),
      const Divider(),
      const Heading('Tab Item'),
      RadioItem<List<TabItem>>(kTabItem[0], _tabItems, handleTabItem),
      RadioItem<List<TabItem>>(kTabItem[1], _tabItems, handleTabItem),
      const Divider(),
      const Heading('Tab Style'),
    ];
    options.addAll(kStyles.map((s) => RadioItem<TabStyle>(
        s, _style, s.value == TabStyle.flip && kIsWeb ? null : handleStyle)));
    options.add(const Divider());
    if (_style.value != TabStyle.fixed &&
        _style.value != TabStyle.fixedCircle) {
      options.add(const Heading('Animation Curve'));
      options.addAll(
          Data.curves.map((c) => RadioItem<Curve>(c, _curve, handleCurve)));
      options.add(const Divider());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Default ConvexAppBar'),
        backgroundColor: _babColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.style),
            color: Colors.white,
            tooltip: "Custom style example",
            onPressed: () => Navigator.of(context).pushNamed('/custom'),
          )
        ],
      ),
      body: ListView(children: options),
      bottomNavigationBar: ConvexAppBar(
        items: _tabItems.value,
        style: _style.value,
        curve: _curve.value,
        backgroundColor: _babColor,
        gradient: _gradient,
        onTap: (int i) => debugPrint('select index=$i'),
      ),
    );
  }

  void handleTabItem(ChoiceValue<List<TabItem>> value) {
    setState(() {
      _tabItems = value;
    });
  }

  void handleStyle(ChoiceValue<TabStyle> value) {
    setState(() {
      _style = value;
    });
  }

  void handleCurve(ChoiceValue<Curve> value) {
    setState(() {
      _curve = value;
    });
  }

  void _onBabColorChanged(Color value) {
    setState(() {
      _babColor = value;
    });
  }

  void _onGradientChanged(Gradient value) {
    setState(() {
      _gradient = value;
    });
  }
}
