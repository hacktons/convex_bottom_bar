import 'package:convex_app_bar_example/components/gradient_item.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'components/colors_item.dart';
import 'components/heading.dart';
import 'components/radio_item.dart';
import 'model/choice_value.dart';
import 'model/named_color.dart';

class DefaultAppBarDemo extends StatefulWidget {
  @override
  State createState() {
    return _State();
  }
}

class _State extends State<DefaultAppBarDemo> {
  static const INDEX_PUBLISH = 2;
  final tabItems = <TabItem>[
    // use icon
    const TabItem<IconData>(icon: Icons.home, title: 'Home'),
    // use image
    TabItem<Widget>(icon: Image.asset('images/sample.png'), title: 'Discovery'),
    const TabItem<IconData>(icon: Icons.publish, title: "Publish"),
    const TabItem<IconData>(icon: Icons.message, title: 'Message'),
    const TabItem<IconData>(icon: Icons.people, title: 'Profile'),
  ];
  static const ACTIVE_COLOR = Colors.red;
  static const NORMAL_COLOR = Colors.black;

  static const kStyles = [
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
  ];
  static const kCurves = [
    ChoiceValue<Curve>(
      title: 'Curves.linear',
      label: 'The curve linear is used',
      value: Curves.linear,
    ),
    ChoiceValue<Curve>(
      title: 'Curves.decelerate',
      value: Curves.decelerate,
      label: 'The curve decelerate is used',
    ),
    ChoiceValue<Curve>(
      title: 'Curves.easeInOut',
      value: Curves.easeInOut,
      label: 'The curve easeInOut is used',
    ),
    ChoiceValue<Curve>(
      title: 'Curves.fastOutSlowIn',
      value: Curves.fastOutSlowIn,
      label: 'The curve fastOutSlowIn is used',
    ),
    ChoiceValue<Curve>(
      title: 'Curves.slowMiddle',
      value: Curves.slowMiddle,
      label: 'The curve slowMiddle is used',
    ),
  ];
  static const List<NamedColor> kBabColors = [
    NamedColor(Colors.blue, 'Blue'),
    NamedColor(Color(0xFFf44336), 'Read'),
    NamedColor(Color(0xFF673AB7), 'Purple'),
    NamedColor(Color(0xFF009688), 'Green'),
    NamedColor(Color(0xFFFFC107), 'Yellow'),
    NamedColor(Color(0xFF607D8B), 'Grey'),
  ];
  static const List<Gradient> kGradients = [
    null,
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blue, Colors.redAccent, Colors.green, Colors.blue],
      tileMode: TileMode.repeated,
    ),
    LinearGradient(
      begin: Alignment.center,
      end: Alignment(-1, 1),
      colors: [Colors.redAccent, Colors.green, Colors.blue],
      tileMode: TileMode.repeated,
    ),
    RadialGradient(
      center: const Alignment(0, 0), // near the top right
      radius: 5,
      colors: [Colors.green, Colors.blue, Colors.redAccent],
    )
  ];

  ChoiceValue<TabStyle> _style = kStyles.first;
  ChoiceValue<Curve> _curve = kCurves.first;
  Color _babColor = kBabColors.first.color;
  Gradient _gradient = kGradients.first;

  @override
  Widget build(BuildContext context) {
    debugPrint('build');
    var options = <Widget>[
      const Heading('Appbar Color Example'),
      ColorsItem(kBabColors, _babColor, _onBabColorChanged),
      const Divider(),
      const Heading('Background Gradient Example'),
      GradientItem(kGradients, _gradient, _onGradientChanged),
      const Heading('Tab Style'),
    ];
    options.addAll(
        kStyles.map((s) => RadioItem<TabStyle>(s, _style, handleStyle)));
    options.add(const Divider());
    if (_style.value != TabStyle.fixed &&
        _style.value != TabStyle.fixedCircle) {
      options.add(const Heading('Animation Curve Example'));
      options
          .addAll(kCurves.map((c) => RadioItem<Curve>(c, _curve, handleCurve)));
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
        items: tabItems,
        style: _style.value,
        curve: _curve.value,
        backgroundColor: _babColor,
        gradient: _gradient,
        onTap: (int i) => debugPrint('select index=$i'),
      ),
    );
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
