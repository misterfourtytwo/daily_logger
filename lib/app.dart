import 'package:flutter/material.dart';

import 'package:daily_logger/views/home.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily logger',
      home: Home(),
    );
  }
}
