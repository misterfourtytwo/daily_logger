import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/payment.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/config_provider.dart';
import 'package:daily_logger/services/log_provider.dart';

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

    return SingleChildScrollView(
      child: Container(
        height: height + 12,
        decoration: BoxDecoration(
          // color: Colors.blueGrey[700],
          border: Border(
            top: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 6.0,
            ),
          ),
        ),
        padding: EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 12),
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
                  minLines: 1,
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
                        size: 24,
                        color: Colors.teal,
                      ),
                      onPressed: value != LogTypes.note
                          ? () => _config.activeType.value = LogTypes.note
                          : null,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.track_changes,
                        size: 24,
                        color: Colors.teal,
                      ),
                      onPressed: value != LogTypes.note
                          ? () => _config.activeType.value = LogTypes.note
                          : null,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.payment,
                        size: 24,
                        color: Colors.yellow,
                      ),
                      onPressed: value != LogTypes.task
                          ? () => _config.activeType.value = LogTypes.task
                          : null,
                    ),
                    if (value == LogTypes.payment) ...[
                      Text('Price'),
                      Container(
                        width: 64,
                        child: TextField(
                          controller: _priceController,
                          textAlign: TextAlign.end,
                          maxLines: 1,
                          keyboardType: TextInputType.numberWithOptions(
                            signed: true,
                            decimal: true,
                          ),
                        ),
                      ),
                      Text('Already paid?'),
                      Checkbox(
                        value: paidCheckbox ?? false,
                        onChanged: (newValue) => setState(() {
                          paidCheckbox = newValue;
                        }),
                      ),
                    ],
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
                              log.alreadyPaid = paidCheckbox;
                              log.price = Payment(
                                  double.tryParse(_priceController.text));
                              break;
                            case LogTypes.note:
                            default:
                              log = Log.note();
                              log.title = _titleController.text;
                              log.content = _contentController.text;
                          }
                          _logs.createLog(log);
                          setState(() {
                            _titleController.clear();
                            _contentController.clear();
                            _priceController.clear();
                            paidCheckbox = false;
                          });
                        },
                  child: Text(
                    'Log!',
                    style: TextStyle(fontSize: 18),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
