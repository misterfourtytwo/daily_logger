import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Daily logger',
        home: Scaffold(
          body: Container(
            alignment: Alignment.center,
            child: Text('Daily logger app'),
          ),
        ));
  }
}
