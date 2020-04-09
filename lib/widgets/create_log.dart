import 'dart:math';

import 'package:daily_logger/widgets/buttons/focusable_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:daily_logger/config/strings.dart';
import 'package:daily_logger/config/styles.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/config_provider.dart';
import 'package:daily_logger/services/create_log_provider.dart';
import 'package:daily_logger/utils/date_extensions.dart';
import 'package:daily_logger/widgets/buttons/type_button.dart';

final _sl = GetIt.instance;

class CreateLogWidget extends StatefulWidget {
  CreateLogWidget({@required this.size, Key key}) : super(key: key);
  final Size size;

  @override
  _CreateLogWidgetState createState() => _CreateLogWidgetState();
}

class _CreateLogWidgetState extends State<CreateLogWidget> {
  TextEditingController _contentController, _titleController, _priceController;
  ConfigProvider _config;
  CreateLogProvider _createLogProvider;

  TextEditingController _searchTextController;

  double get _height => widget.size.height * .4;
  double get _width => widget.size.width;
  bool get grepToggle => _config.grepToggle.value;
  // LogTypes get activeType => _createLogProvider.activeType.value;

  @override
  void initState() {
    super.initState();
    _config = _sl<ConfigProvider>();
    _createLogProvider = CreateLogProvider(this._setFields);

    _titleController = TextEditingController();
    _contentController = TextEditingController();
    _priceController = TextEditingController();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    _createLogProvider.dispose();

    _titleController.dispose();
    _contentController.dispose();
    _priceController.dispose();
    _searchTextController.dispose();
    super.dispose();
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
                onChanged: (value) => setState(() {
                  _createLogProvider.title = value;
                }),
                decoration: Styles.myInputDecoration(labelText: 'Log title'),
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
                decoration: Styles.myInputDecoration(
                  labelText: 'Log content',
                ),
                controller: _contentController,
                onChanged: (value) => setState(() {
                  _createLogProvider.content = value;
                }),
              ),
            ),

            if (_createLogProvider.type == LogTypes.payment)
              buildPaymentRow(context),
            if (_createLogProvider.type == LogTypes.task)
              buildTaskRow(context),
            if (_createLogProvider.type == LogTypes.continuous)
              buildContinuousRow(context),
            FocusableButtonWidget(
              onPressed: _createLogProvider.title.isEmpty
                  ? null
                  : () {
                      _createLogProvider.saveLog();
                      _clearFields();
                    },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Text(
                  'Log!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuRow(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: min(_width - 194, 438),
          height: 64,
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: grepToggle
              ? Container(
                  child: TextField(
                    maxLines: 1,
                    controller: _searchTextController,
                    toolbarOptions: ToolbarOptions(
                        copy: true, paste: true, selectAll: true, cut: true),
                    // maxLength: 64,
                    // maxLengthEnforced: true,
                    decoration:
                        Styles.myInputDecoration(labelText: 'Filter logs'),
                  ),
                )
              // created log type
              : Container(
                  // margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: Styles.myBoxDecoration(),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: [
                      LogTypes.note,
                      LogTypes.payment,
                      LogTypes.task,
                      LogTypes.continuous
                    ]
                            .expand((buttonType) => [
                                  TypeButtonWidget(
                                    label:
                                        Text(Strings.logTypeNames[buttonType]),
                                    icon: Icon(
                                      Styles.logTypeIcons[buttonType],
                                      size: 28,
                                      color: Styles.logTypeColors[buttonType],
                                    ),
                                    onPressed:
                                        _createLogProvider.type != buttonType
                                            ? () => changeActiveType(buttonType)
                                            : null,
                                  ),
                                  if (buttonType != LogTypes.continuous)
                                    Container(width: 3, color: Colors.white30),
                                ])
                            .toList()),
                  ),
                ),
        ),
        Spacer(),
        FocusableButtonWidget(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color:
                _config.grepToggle.value ? Colors.white24 : Colors.transparent,
            child: Text('grep'),
          ),
          onPressed: () => setState(() {
            _config.grepToggle.value ^= true;
          }),
        ),
        FocusableButtonWidget(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('settings'),
          ),
          onPressed: () {
            print('pressed settings');
          },
        ),
      ],
    );
  }

  changeActiveType(LogTypes type) {
    _createLogProvider.type = type;
    setState(() {});
  }

  Widget buildPaymentRow(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: <Widget>[
          Container(
            width: 120,
            child: TextField(
              controller: _priceController,
              textAlign: TextAlign.end,
              maxLines: 1,
              decoration: Styles.myInputDecoration(labelText: 'Price'),
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: true),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text('\$'),
          ),
          Spacer(),
          Text('Already paid?'),
          Checkbox(
            value: _createLogProvider.paymentPaid ?? false,
            activeColor: Colors.white38,
            checkColor: Colors.white70,
            focusColor: Colors.pink,
            onChanged: (newValue) => setState(() {
              _createLogProvider.paymentPaid = newValue;
            }),
          ),
        ],
      ),
    );
  }

  String dateString(DateTime value) {
    final today = DateTime.now();

    if (value == null || value.date == DateTime(0)) return 'Date';

    if (value.year == today.year) {
      if (value.month == today.month) if (value.day == today.day) {
        return 'Today';
      } else {
        return value.day.toString();
      }
      else {
        return value.monthDay;
      }
    } else {
      return value.yearMonthDay;
    }
  }

  Widget buildTaskRow(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text('Task deadline:'),
            FocusableButtonWidget(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(dateString(_createLogProvider.deadlineDate)),
                ),
                onPressed: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context,
                      // initialDatePickerMode: DatePickerMode.day,
                      // initialEntryMode: DatePickerEntryMode.input,
                      initialDate:
                          _createLogProvider.deadlineDate ?? DateTime.now(),
                      firstDate: DateTime(1972),
                      lastDate: DateTime(2100));
                  if (pickedDate != null &&
                      pickedDate != _createLogProvider.deadlineDate)
                    setState(() {
                      _createLogProvider.deadlineDate = pickedDate;
                    });
                }),
            FocusableButtonWidget(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: Text(
                      _createLogProvider.deadlineTime?.format(context) ??
                          'Time'),
                ),
                onPressed: () async {
                  TimeOfDay pickedTime = await showTimePicker(
                      context: context,
                      // initialDatePickerMode: DatePickerMode.day,
                      // initialEntryMode: DatePickerEntryMode.input,
                      initialTime:
                          _createLogProvider.deadlineTime ?? TimeOfDay.now());

                  if (pickedTime != null &&
                      pickedTime != _createLogProvider.deadlineTime) {}
                  setState(() {
                    _createLogProvider.deadlineTime = pickedTime;
                  });
                }),
            Spacer(),
            Text('Completed?'),
            Checkbox(
              value: _createLogProvider.taskCompleted ?? false,
              activeColor: Colors.white38,
              checkColor: Colors.white70,
              focusColor: Colors.pink,
              // hoverColor: Colors.pink,
              onChanged: (newValue) => setState(() {
                _createLogProvider.taskCompleted = newValue;
              }),
            ),
          ],
        ),
      );

  Widget buildContinuousRow(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ChangeNotifierProvider.value(
          value: _createLogProvider,
          child: Consumer<CreateLogProvider>(
            builder: (context, provider, _) => Row(
              children: [
                Text('Happened from'),
                FocusableButtonWidget(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text(
                          dateString(_createLogProvider.businessStartDate)),
                    ),
                    onPressed: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          // initialDatePickerMode: DatePickerMode.day,
                          // initialEntryMode: DatePickerEntryMode.input,
                          initialDate: _createLogProvider.businessStartDate ??
                              DateTime.now(),
                          firstDate: DateTime(1972),
                          lastDate: DateTime(2100));
                      if (pickedDate != null &&
                          pickedDate != _createLogProvider.businessStartDate)
                        setState(() {
                          _createLogProvider.businessStartDate = pickedDate;
                        });
                    }),
                FocusableButtonWidget(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text(_createLogProvider.businessStartTime
                              ?.format(context) ??
                          'Time'),
                    ),
                    onPressed: () async {
                      TimeOfDay pickedTime = await showTimePicker(
                          context: context,
                          // initialDatePickerMode: DatePickerMode.day,
                          // initialEntryMode: DatePickerEntryMode.input,
                          initialTime: _createLogProvider.businessStartTime ??
                              TimeOfDay.now());

                      if (pickedTime != null &&
                          pickedTime != _createLogProvider.businessStartTime) {}
                      setState(() {
                        _createLogProvider.businessStartTime = pickedTime;
                      });
                    }),
                Text('until'),
                FocusableButtonWidget(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child:
                          Text(dateString(_createLogProvider.businessEndDate)),
                    ),
                    onPressed: () async {
                      DateTime pickedDate = await showDatePicker(
                          context: context,
                          // initialDatePickerMode: DatePickerMode.day,
                          // initialEntryMode: DatePickerEntryMode.input,
                          initialDate: _createLogProvider.businessEndDate ??
                              DateTime.now(),
                          firstDate: DateTime(1972),
                          lastDate: DateTime(2100));
                      if (pickedDate != null &&
                          pickedDate != _createLogProvider.businessEndDate)
                        setState(() {
                          _createLogProvider.businessEndDate = pickedDate;
                        });
                    }),
                FocusableButtonWidget(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text(
                          _createLogProvider.businessEndTime?.format(context) ??
                              'Time'),
                    ),
                    onPressed: () async {
                      TimeOfDay pickedTime = await showTimePicker(
                          context: context,
                          // initialDatePickerMode: DatePickerMode.day,
                          // initialEntryMode: DatePickerEntryMode.input,
                          initialTime: _createLogProvider.businessEndTime ??
                              TimeOfDay.now());

                      if (pickedTime != null &&
                          pickedTime != _createLogProvider.businessEndTime) {}
                      setState(() {
                        _createLogProvider.businessEndTime = pickedTime;
                      });
                    }),
              ],
            ),
          ),
        ),
      );

  void _setFields({String title, String content, String price}) {
    setState(() {
      _titleController.clear();
      _titleController.text = title;
      _contentController.clear();
      _contentController.text = content;
      _priceController.clear();
      _priceController.text = price;
    });
  }

  void _clearFields() {
    setState(() {
      _titleController.clear();
      _contentController.clear();
      _priceController.clear();
    });
  }
}
