import 'package:flutter/material.dart';

import 'package:daily_logger/utils/date_extensions.dart';

class DateBubblepWidget extends StatelessWidget {
  const DateBubblepWidget(this.date, {Key key}) : super(key: key);
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border.all(
      //     // top: BorderSide(
      //     color: Theme.of(context).dividerColor,
      //     width: 1,
      //     // ),
      //   ),
      //   borderRadius: BorderRadius.circular(12),
      // ),
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      // margin: EdgeInsets.all(8),
      alignment: Alignment.center,
      child: Text(date.monthDay),
    );
  }
}
