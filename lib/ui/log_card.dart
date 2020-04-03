import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/log_types.dart';

const _typeColors = {
  LogTypes.note: Colors.teal,
  LogTypes.payment: Colors.yellow,
};
final _formatter = DateFormat.Hms();

class LogCardWidget extends StatelessWidget {
  final Log log;

  const LogCardWidget({this.log, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Theme.of(context).accentColor,
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      )),
      padding: EdgeInsets.all(12),
      // alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RichText(
              // textAlign: TextAlign.end,
              text: TextSpan(
            children: [
              TextSpan(text: '${_formatter.format(log.date)} '),
              TextSpan(
                text: log.title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                  text: ' [${log.readableType}]',
                  style: TextStyle(
                    color: _typeColors[log.type],
                  )),
            ],
          )),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 4.0),
            child: RichText(
              text: TextSpan(text: log.content),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
