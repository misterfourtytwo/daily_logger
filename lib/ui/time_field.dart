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
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 42,
      child: Placeholder(),
    );
  }
}
