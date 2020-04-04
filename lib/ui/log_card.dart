import 'dart:math';

import 'package:flutter/material.dart';

import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/ui/date_bubble.dart';
import 'package:daily_logger/utils/date_extensions.dart';

const _typeColors = {
  LogTypes.note: Colors.teal,
  LogTypes.payment: Colors.yellow,
};

class LogCardWidget extends StatelessWidget {
  final Log log;
  final bool showDate;
  const LogCardWidget({this.log, this.showDate = false, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) => SizedBox(
          // width: size.maxWidth,
          // padding: EdgeInsets.only(left: 12, right: 12, bottom: 12),
          // alignment: Alignment.centerLeft,
          child: Column(
        children: <Widget>[
          if (showDate) ...[
            Divider(
              height: 2,
            ),
            SizedBox(height: 4),
            Container(
              // margin: EdgeInsets.only(top: 8),
              child: DateBubblepWidget(log.date),
              width: max(size.maxWidth * 0.3, 60),
            ),
            SizedBox(height: 4),
          ],
          Divider(
            height: 2,
          ),
          SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  alignment: Alignment.topCenter,
                  width: max(size.maxWidth * 0.09, 48),
                  child: Text(
                    log.date.hourMinute,
                    style: TextStyle(color: Colors.white60),
                  )),
              Expanded(
                child: Container(
                  child: Text(
                    // text:
                    log.title,
                    style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.w500,
                    ),
                    // ),
                  ),
                ),
              ),
              Container(
                width: max(size.maxWidth * 0.16, 66),
                // color: Colors.red,
                alignment: Alignment.topRight,
                child: RichText(

                    // textAlign: TextAlign.end,
                    text: TextSpan(
                  text: '[${log.readableType}]',
                  style: TextStyle(
                    color: _typeColors[log.type],
                  ),
                )
                    // ),
                    ),
              )
            ],
          ),
          if (!log.isInstant) ...[
            Container(height: 42, color: Colors.green),
            // if (log.i)
          ],
          if (log.isPayment) ...[
            Row(
              children: [
                Container(
                  width: size.maxWidth * 0.2,
                  alignment: Alignment.topRight,
                  child: RichText(
                      text: TextSpan(children: [
                    TextSpan(text: 'Price: '),
                    TextSpan(text: log.price.toString()),
                  ])),
                ),
                Container(
                  width: size.maxWidth * 0.2,
                  alignment: Alignment.topRight,
                  child: Text('Paid? '),
                ),
              ],
            ),
          ],
          if (log.content != null && log.content.isNotEmpty)
            Container(
              padding: EdgeInsets.only(left: size.maxWidth * 0.05),
              alignment: Alignment.topLeft,
              child: Text(
                log.content,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Colors.white60,
                ),
              ),
            ),
          SizedBox(height: 4),
        ],
      )),
    );
  }
}
