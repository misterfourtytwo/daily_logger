import 'dart:math';

import 'package:daily_logger/config/strings.dart';
import 'package:flutter/material.dart';

import 'package:daily_logger/config/styles.dart';
import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/widgets/date_bubble.dart';
import 'package:daily_logger/utils/date_extensions.dart';

class LogCardWidget extends StatelessWidget {
  final Log log;
  final bool showDate;
  final bool currentEdit;

  const LogCardWidget(
      {this.log, this.showDate = false, this.currentEdit = false, Key key})
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
          // Date bubble
          if (showDate) ...[
            Divider(
              height: 2,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4),
              child: DateBubblepWidget(log.date),
              width: max(size.maxWidth * 0.3, 60),
            ),
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
                alignment: Alignment.topRight,
                child: RichText(
                    text: TextSpan(
                  text: '[${Strings.logTypeNames[log.type]}]',
                  style: TextStyle(
                    color: Styles.logTypeColors[log.type],
                  ),
                )),
              )
            ],
          ),
          if (log.isPayment)
            Row(
              children: [
                SizedBox(
                  width: size.maxWidth * .09,
                ),
                Container(
                  // width: size.maxWidth * .2,
                  alignment: Alignment.topRight,
                  child: Text('Price: '),
                ),
                Container(
                    width: size.maxWidth * .3,
                    alignment: Alignment.topLeft,
                    child: Text(log.price.toString())),
                // SizedBox(
                //   width: size.maxWidth * .09,
                // ),
                Spacer(),
                Container(
                  width: size.maxWidth * .2,
                  alignment: Alignment.topRight,
                  child: Text('Paid? '),
                ),
                Container(
                  // width: size.maxWidth * .04,
                  alignment: Alignment.topLeft,
                  child: Icon(
                    log.alreadyPaid != null && log.alreadyPaid
                        ? Icons.check_box
                        : Icons.clear,
                    color: log.alreadyPaid != null && log.alreadyPaid
                        ? Colors.amber
                        : Colors.grey.withOpacity(.4),
                    size: 24,
                  ),
                ),
              ],
            ),
          if (log.content != null && log.content.isNotEmpty)
            Container(
              padding: EdgeInsets.only(left: size.maxWidth * .09),
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
