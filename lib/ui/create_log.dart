import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:daily_logger/models/log.dart';
import 'package:daily_logger/models/payment.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/config_provider.dart';
import 'package:daily_logger/services/log_provider.dart';

final _sl = GetIt.instance;

class CreateLogWidget extends StatefulWidget {
  CreateLogWidget({@required this.size, Key key}) : super(key: key);
  Size size;

  @override
  _CreateLogWidgetState createState() => _CreateLogWidgetState();
}

class _CreateLogWidgetState extends State<CreateLogWidget> {
  ConfigProvider _config;
  LogProvider _logs;

  TextEditingController _contentController, _titleController, _priceController;
  bool _paidCheckbox;
  int _editId;

  double get _height => widget.size.height * .4;
  double get _width => widget.size.width;
  LogTypes get activeType => _config.activeType.value;
  bool get grepToggle => _config.grepToggle.value;

  @override
  void initState() {
    super.initState();
    _config = _sl<ConfigProvider>();
    _logs = _sl<LogProvider>();

    _titleController = TextEditingController();
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

  Widget buildMenuRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: _width - 188,
          height: 48,
          child: grepToggle
              // TODO filter field
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(),
                )
              // created log type
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    FlatButton(
                      child: Icon(
                        Icons.note,
                        size: 24,
                        color: Colors.teal,
                      ),
                      disabledColor: Colors.black38,
                      onPressed: activeType != LogTypes.note
                          ? () => changeActiveType(LogTypes.note)
                          : null,
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.attach_money,
                        size: 24,
                        color: Colors.amber,
                      ),
                      disabledColor: Colors.black38,
                      onPressed: activeType != LogTypes.payment
                          ? () => changeActiveType(LogTypes.payment)
                          : null,
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.access_alarm,
                        size: 24,
                        color: Colors.blue,
                      ),
                      disabledColor: Colors.black38,
                      onPressed: activeType != LogTypes.task
                          ? () => changeActiveType(LogTypes.task)
                          : null,
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.update,
                        size: 24,
                        color: Colors.pink[300],
                      ),
                      disabledColor: Colors.black38,
                      onPressed: activeType != LogTypes.continuous
                          ? () => changeActiveType(LogTypes.continuous)
                          : null,
                    ),
                  ]),
                ),
        ),
        FlatButton(
          child: Text('grep'),
          color: grepToggle ? Colors.black38 : Colors.transparent,
          onPressed: () => setState(() {
            _config.grepToggle.value ^= true;
          }),
        ),
        FlatButton(
          child: Text('settings'),
          // color: grepToggle ? Colors.black38 : Colors.transparent,
          onPressed: null,
        ),
      ],
    );
  }

  changeActiveType(LogTypes type) {
    _config.activeType.value = type;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height + 6,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 6.0,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildMenuRow(context),
            // title field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: _titleController,
                onChanged: (value) => setState(() {}),
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white70, width: 3)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white54, width: 2)),
                  labelText: 'Log title',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    color: Colors.white54,
                  ),
                ),
                maxLines: 1,
                maxLength: 64,
                maxLengthEnforced: true,
              ),
            ),
            // content field
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                maxLines: 4,
                maxLength: 640,
                maxLengthEnforced: true,
                decoration: InputDecoration(
                  isDense: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white70, width: 3)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(color: Colors.white54, width: 2)),
                  labelText: 'Log content',
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(
                    color: Colors.white54,
                  ),
                ),
                controller: _contentController,
              ),
            ),
            if (_config.activeType.value == LogTypes.payment) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      child: TextField(
                        controller: _priceController,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        decoration: InputDecoration(
                          isDense: true,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(color: Colors.white70, width: 3)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              borderSide:
                                  BorderSide(color: Colors.white54, width: 2)),
                          labelText: 'Price',
                          alignLabelWithHint: true,
                          labelStyle: TextStyle(
                            color: Colors.white54,
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Text('\$'),
                    ),
                    Spacer(),
                    Text('Already paid?'),
                    Checkbox(
                      value: _paidCheckbox ?? false,
                      activeColor: Colors.white38,
                      checkColor: Colors.white70,
                      focusColor: Colors.pink,
                      // hoverColor: Colors.pink,
                      onChanged: (newValue) => setState(() {
                        _paidCheckbox = newValue;
                      }),
                    ),
                  ],
                ),
              ),
            ],

            Container(
                child: MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              onPressed: _titleController.text.isEmpty ? null : saveLog,
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

  void saveLog() {
    Log log;
    print(_config.activeType.value);
    switch (_config.activeType.value) {
      case LogTypes.payment:
        log = Log.payment();
        log.title = _titleController.text;
        log.content = _contentController.text;
        log.alreadyPaid = _paidCheckbox;
        log.price = Payment(double.tryParse(_priceController.text));
        break;
      case LogTypes.note:
      default:
        log = Log.note();
        log.title = _titleController.text;
        log.content = _contentController.text;
    }
    _logs.createLog(log);
    clearFields();
  }

  void populateFields(Log log) {
    setState(() {
      _editId = log.id;
      _titleController.clear();
      _titleController.text = log.title;
      _contentController.clear();
      _contentController.text = log.content;
      _priceController.clear();
      _priceController.text = log.price.value.toString();
      _paidCheckbox = log.alreadyPaid;
    });
  }

  void clearFields() {
    setState(() {
      _editId = null;
      _titleController.clear();
      _contentController.clear();
      _priceController.clear();
      _paidCheckbox = false;
    });
  }
}
