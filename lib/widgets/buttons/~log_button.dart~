import 'package:flutter/material.dart';

typedef UpdateCallback(TimeOfDay newTime);

class TimeFieldWidget extends StatefulWidget {
  TimeFieldWidget({this.value, this.onChanged, Key key}) : super(key: key);
  final TimeOfDay value;
  final UpdateCallback onChanged;

  @override
  _TimeFieldWidgetState createState() => _TimeFieldWidgetState();
}

class _TimeFieldWidgetState extends State<TimeFieldWidget> {
  TimeOfDay value;
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
              TimeOfDay pickedTime = await showTimePicker(
                  context: context,
                  // initialDatePickerMode: DatePickerMode.day,
                  // initialEntryMode: DatePickerEntryMode.input,
                  initialTime: value ?? TimeOfDay.now());

              if (pickedTime != null && pickedTime != value) {}
              setState(() {
                value = pickedTime;
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
              child: Text(value?.format(context) ?? 'Time'),
            ),
          ),
        ),
      ),
    );
  }
}
