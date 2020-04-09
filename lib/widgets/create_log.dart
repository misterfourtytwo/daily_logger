import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:daily_logger/config/strings.dart';
import 'package:daily_logger/config/styles.dart';
import 'package:daily_logger/models/log_types.dart';
import 'package:daily_logger/services/config_provider.dart';
import 'package:daily_logger/services/create_log_provider.dart';
import 'package:daily_logger/widgets/buttons/date_field.dart';
import 'package:daily_logger/widgets/buttons/time_field.dart';
import 'package:daily_logger/widgets/buttons/type_button.dart';
import 'package:provider/provider.dart';

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

            Container(
                child: MaterialButton(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              onPressed: _createLogProvider.title.isEmpty
                  ? null
                  : () {
                      _createLogProvider.saveLog();
                      _clearFields();
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
        FlatButton(
          child: Text('grep'),
          color: grepToggle ? Colors.white38 : Colors.transparent,
          onPressed: () => setState(() {
            _config.grepToggle.value ^= true;
          }),
        ),
        FlatButton(
          child: Text('settings'),
          // color: grepToggle ? Colors.black38 : Colors.transparent,
          onPressed: () {
            print('pressed settings');
          },
        ),
        SizedBox(
          width: 18,
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

  Widget buildTaskRow(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text('Task deadline:'),
            DateFieldWidget(
              onChanged: (newDate) => setState(() {
                _createLogProvider.deadlineDate = newDate;
              }),
            ),
            TimeFieldWidget(
              onChanged: (newTime) => setState(() {
                _createLogProvider.deadlineTime = newTime;
              }),
            ),
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
                DateFieldWidget(
                  value: provider.businessStartDate,
                  onChanged: (newDate) => provider.businessStartDate = newDate,
                ),
                Text('until'),
                DateFieldWidget(
                  value: provider.businessEndDate,
                  onChanged: (newDate) => provider.businessEndDate = newDate,
                ),
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
