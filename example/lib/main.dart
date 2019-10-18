import 'package:bulged_bottom_bar_example/custom_appbar_sample.dart';
import 'package:bulged_bottom_bar_example/default_appbar_demo.dart';
import 'package:flutter/material.dart';

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
        "/": (BuildContext context) => Home(),
        "/default": (BuildContext context) => DefaultAppBarDemo(),
        "/custom": (BuildContext context) => CustomAppBarDemo(),
      },
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ConvexAppBar Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text('Default  ConvexAppBar',
                  style: TextStyle(fontSize: 20.0)),
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () => Navigator.of(context).pushNamed('/default'),
            ),
            FlatButton(
              child:
                  Text('Custom ConvexAppBar', style: TextStyle(fontSize: 20.0)),
              color: Colors.blue,
              textColor: Colors.white,
              disabledColor: Colors.grey,
              disabledTextColor: Colors.black,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.blueAccent,
              onPressed: () => Navigator.of(context).pushNamed('/custom'),
            ),
          ],
        ),
      ),
    );
  }
}
