import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:daily_logger/views/home.dart';
import 'package:daily_logger/services/config_provider.dart';

final _sl = GetIt.I;

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily logger',
      theme: ThemeData(
        fontFamily: 'Fira Code',
        brightness: Brightness.dark,
        // primarySwatch: Colors.brown,
        // primaryColorDark: Colors.blueGrey,
        // primaryColor: Colors.blueGrey[900],
        // accentColor: Colors.blueGrey[800],
        // canvasColor: Colors.orange,
        // highlightColor: Colors.pink,
        // splashColor: Colors.blueGrey[400],
        // cardColor: Colors.deepPurple,
        // disabledColor: Colors.grey[400],
        // cursorColor: Colors.blueGrey[200],

        // colorScheme: ColorScheme(
        //   primary: Colors.blueGrey[900],
        //   primaryVariant: Colors.blueGrey[700],
        //   secondary: Colors.blueGrey[600],
        //   secondaryVariant: Colors.teal[600],
        //   surface: Colors.blueGrey[700],
        //   background: Colors.blueGrey[900],
        //   error: Colors.red,
        //   onPrimary: Colors.red,
        //   onSecondary: Colors.red,
        //   onSurface: Colors.red,
        //   onBackground: Colors.red,
        //   onError: Colors.red,
        //   brightness: Brightness.dark,
        // ),
      ),
      home: ChangeNotifierProvider.value(
        value: _sl<ConfigProvider>(),
        child: Home(),
      ),
    );
  }
}
