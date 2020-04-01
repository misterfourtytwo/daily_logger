import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:flutter/material.dart';

const _typeColors = {
  LogTypes.note: Colors.teal,
  LogTypes.payment: Colors.yellow,
};

class LogCardWidget extends StatelessWidget {
  final Log log;

  const LogCardWidget({this.log, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: ListTile(
          title: Text(
        log.toString(),
        style: TextStyle(color: _typeColors[log.type]),
      )),
      margin: EdgeInsets.only(top: 8),
    );
  }
}
