import 'package:daily_logger/ui/create_log.dart';
import 'package:daily_logger/ui/log_card.dart';
import 'package:flutter/material.dart';

import 'package:daily_logger/models/log.dart';

List<Log> logs = [
  Log(title: 'zero', content: 'two'),
  Log(title: 'naruto', content: 'uzumaki')
];

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: logs.map((log) => LogCardWidget(log: log)).toList(),
              ),
            ),
            CreateLogWidget(),
            Container(
              padding: EdgeInsets.all(16),
              height: 64,
              child: Text(
                'NAV BAR',
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            )
          ],
        ),
      ),
    );
  }
}
