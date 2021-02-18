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

import 'package:convex_app_bar_example/convex_button_demo.dart';
import 'package:convex_app_bar_example/custom_appbar_sample.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
        "/": (_) => HelloConvexAppBar(),
        "/bar": (BuildContext context) => DefaultAppBarDemo(),
        "/custom": (BuildContext context) => CustomAppBarDemo(),
        "/fab": (BuildContext context) => ConvexButtonDemo(),
      },
    );
  }
}

class HelloConvexAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello ConvexAppBar')),
      body: Center(
          child: TextButton(
        child: Text('Click to show full example'),
        onPressed: () => Navigator.of(context).pushNamed('/bar'),
      )),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: [
          TabItem(icon: Icons.list),
          TabItem(icon: Icons.calendar_today),
          TabItem(icon: Icons.assessment),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => print('click index=$i'),
      ),
    );
  }
}
