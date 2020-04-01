import 'package:daily_logger/services/log_provider.dart';
import 'package:flutter/material.dart';

import 'package:daily_logger/models/log.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

final _sl = GetIt.instance;

class CreateLogWidget extends StatefulWidget {
  CreateLogWidget({Key key}) : super(key: key);

  @override
  _CreateLogWidgetState createState() => _CreateLogWidgetState();
}

class _CreateLogWidgetState extends State<CreateLogWidget> {
  // double get getHeight => log;
  Log log;
  TextEditingController _contentController, _titleController, _priceController;
  @override
  void initState() {
    super.initState();
    // TODO add dependency on settings
    log = Log.note();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = 200;
    double titleHeight = 48;
    double contentHeight = 110;
    // double bot = 64;

    return Container(
      height: height,
      color: Colors.blueGrey[700],
      padding: EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: height - titleHeight,
              top: 0,
              left: 0,
              right: 0,
              child: TextField(
                style: TextStyle(
                  color: Colors.blue,
                ),
                // enableInteractiveSelection: true,

                decoration: InputDecoration(
                  // isDense: true,
                  hintText: 'Title',
                ),
                // maxLines: 1,
                onChanged: (txt) => log.title = txt,
              )),
          Positioned(
              bottom: height - titleHeight - contentHeight,
              top: titleHeight,
              left: 0,
              right: 0,
              child: TextField(
                style: TextStyle(color: Colors.blue),
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Log content'),
                controller: _contentController,
                onChanged: (txt) => log.content = txt,
                // keyboardType: ,
                // textInputAction: TextInputAction.send,
                // expands: true,
                // decoration: InputDecoration(
                //   focusColor: Colors.yellowAccent,
                //   hoverColor: Colors.teal,
                //   fillColor: Colors.red,
                // ),
              )),
          Positioned(
            top: titleHeight + contentHeight,
            bottom: 0,
            left: 0,
            width: 32,
            child: Placeholder(
              color: Colors.teal,
            ),
          ),
          Positioned(
              top: titleHeight + contentHeight,
              bottom: 0,
              right: 0,
              // width: 32,
              child: FlatButton(
                onPressed: () {
                  _sl.get<LogProvider>().createLog(log);
                  log = Log();
                },
                textColor: Colors.blue,
                child: Text(
                  'Log!',
                  style: TextStyle(fontSize: 18),
                ),
              )),
        ],
      ),
    );
  }
}
