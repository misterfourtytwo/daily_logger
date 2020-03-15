import 'package:daily_logger/models/log.dart';
import 'package:flutter/material.dart';

class LogCardWidget extends StatelessWidget {
  final Log log;

  const LogCardWidget({this.log, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[600],
      child: ListTile(title: Text(log.toString())),
      margin: EdgeInsets.only(bottom: 16),
    );
  }
}
