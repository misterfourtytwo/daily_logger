import 'package:flutter/material.dart';

import 'package:daily_logger/models/log.dart';

class CreateLogWidget extends StatefulWidget {
  CreateLogWidget({Key key}) : super(key: key);

  @override
  _CreateLogWidgetState createState() => _CreateLogWidgetState();
}

class _CreateLogWidgetState extends State<CreateLogWidget> {
  // double get getHeight => log;
  Log log;

  @override
  void initState() {
    super.initState();
    // TODO add dependency on settings
    log = Log.empty();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints.tight(size),
      height: 180,
      color: Colors.blueGrey[700],
      padding: EdgeInsets.all(8),
      child: Placeholder(
        color: Colors.red,
      ),
    );
  }
}
