import 'package:convex_app_bar_example/custom_appbar_sample.dart';
import 'package:flutter/material.dart';

import 'default_appbar_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State createState() => _State();
}

class _State extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => DefaultAppBarDemo(),
        "/custom": (BuildContext context) => CustomAppBarDemo(),
      },
    );
  }
}
