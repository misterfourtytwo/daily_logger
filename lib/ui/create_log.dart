import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/config_provider.dart';
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
  ConfigProvider _config;
  LogProvider _logs;

  TextEditingController _contentController, _titleController, _priceController;
  bool paidCheckbox;

  @override
  void initState() {
    super.initState();
    _config = _sl<ConfigProvider>();
    _logs = _sl<LogProvider>();

    _titleController = TextEditingController();
    // _titleController.addListener(() {
    //   setState(() {});
    // });

    _contentController = TextEditingController();
    _priceController = TextEditingController();
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
    double titleHeight = 48;
    double contentHeight = 110;
    double buttonsHeight = 64;
    double height = titleHeight + contentHeight + buttonsHeight;
    double buttonWidth = 180;

    return Container(
      height: height,
      decoration: BoxDecoration(
        // color: Colors.blueGrey[700],
        border: Border(
          top: BorderSide(
            // color: Colors.orange,
            width: 6.0,
          ),
        ),
      ),
      padding: EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          Positioned(
              bottom: height - titleHeight,
              top: 0,
              left: 0,
              right: 0,
              child: TextField(
                controller: _titleController,
                onChanged: (value) => setState(() {}),
                style: TextStyle(
                  color: Colors.blue,
                ),
                decoration: InputDecoration(
                  // isDense: true,
                  hintText: 'Title',
                ),
                maxLines: 1,
                // onChanged: (txt) => log.title = txt,
              )),
          Positioned(
              bottom: buttonsHeight,
              top: titleHeight,
              left: 0,
              right: 0,
              child: TextField(
                style: TextStyle(color: Colors.blue),
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Log content'),
                controller: _contentController,
                // onChanged: (txt) => log.content = txt,
                // keyboardType: ,
                // textInputAction: TextInputAction.send,
                // expands: true,
                // decoration: InputDecoration(
                //   focusColor: Colors.yellowAccent,
                //   hoverColor: Colors.teal,
                //   fillColor: Colors.red,
                // ),
              )),

          //buttons

          Positioned(
              top: height - buttonsHeight,
              bottom: 0,
              left: 0,
              right: buttonWidth,
              child: ValueListenableBuilder<LogTypes>(
                valueListenable: _config.activeType,
                builder: (context, value, child) => Row(children: [
                  IconButton(
                    icon: Icon(
                      Icons.note,
                      size: 32,
                      color: Colors.teal,
                    ),
                    onPressed: value != LogTypes.note
                        ? () => _config.activeType.value = LogTypes.note
                        : null,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.payment,
                      size: 32,
                      color: Colors.yellow,
                    ),
                    onPressed: value != LogTypes.payment
                        ? () => _config.activeType.value = LogTypes.payment
                        : null,
                  ),
                  if (value == LogTypes.payment) Text('Already paid'),
                  if (value == LogTypes.payment)
                    Checkbox(
                      value: paidCheckbox ?? false,
                      onChanged: (newValue) => setState(() {
                        paidCheckbox = newValue;
                      }),
                    ),
                ]),
              )),

          Positioned(
              top: height - buttonsHeight,
              bottom: 0,
              right: 0,
              width: buttonWidth,
              child: FlatButton(
                onPressed: _titleController.text.isEmpty
                    ? null
                    : () {
                        Log log;
                        print(_config.activeType.value);
                        switch (_config.activeType.value) {
                          case LogTypes.payment:
                            log = Log.payment();
                            log.title = _titleController.text;
                            log.content = _contentController.text;
                            log.isPaid = paidCheckbox;
                            break;
                          case LogTypes.note:
                          default:
                            log = Log.note();
                            log.title = _titleController.text;
                            log.content = _contentController.text;
                        }
                        _logs.createLog(log);
                        _titleController.clear();
                        _contentController.clear();
                        paidCheckbox = false;
                      },
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
