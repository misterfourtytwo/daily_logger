import 'package:flutter/material.dart';

import 'package:daily_logger/utils/date_extensions.dart';

typedef UpdateCallback(DateTime newDate);

class DateFieldWidget extends StatefulWidget {
  DateFieldWidget({this.value, this.onChanged, Key key}) : super(key: key);
  final DateTime value;
  final UpdateCallback onChanged;

  @override
  _DateFieldWidgetState createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  DateTime value;
  bool focus;
  bool hover;

  @override
  void initState() {
    super.initState();
    focus = false;
    hover = false;
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Semantics(
        container: true,
        button: true,
        enabled: true,
        child: Material(
          elevation: 1,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              width: 3,
              color: hover || focus ? Colors.white70 : Colors.white30,
            ),
          ),
          type: MaterialType.card,
          borderOnForeground: true,
          clipBehavior: Clip.antiAlias,

          // animationDuration: Duration(seconds: 1),
          child: InkWell(
            onTap: () async {
              DateTime pickedDate = await showDatePicker(
                  context: context,
                  // initialDatePickerMode: DatePickerMode.day,
                  // initialEntryMode: DatePickerEntryMode.input,
                  initialDate: value ?? DateTime.now(),
                  firstDate: DateTime(1972),
                  lastDate: DateTime(2100));
              if (pickedDate != null && pickedDate != value)
                setState(() {
                  value = pickedDate;
                  widget.onChanged(value);
                });
            },
            canRequestFocus: true,
            onFocusChange: (bool value) {
              setState(() {
                focus = value;
              });
            },
            // onHighlightChanged: (bool value) {
            //   print('on hightlight change');
            //   print('value $value');
            // },
            onHover: (bool value) {
              setState(() {
                hover = value;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(_dateString),
            ),
          ),
        ),
      ),
    );
  }

  String get _dateString {
    final today = DateTime.now();

    if (value == null) return 'Date';

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
}
