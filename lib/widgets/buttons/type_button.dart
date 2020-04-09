import 'package:flutter/material.dart';

class TypeButtonWidget extends StatelessWidget {
  const TypeButtonWidget({this.onPressed, this.label, this.icon, Key key})
      : super(key: key);
  final VoidCallback onPressed;
  final Widget label;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return OutlineButton.icon(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
      disabledTextColor: Colors.white,
      // focusColor: Colors.orange,
      // disabledBorderColor: Colors.orange,
      textColor: Colors.white38,
      color: Colors.transparent,
      splashColor: Colors.white30,
      highlightedBorderColor: Colors.transparent,
      borderSide: BorderSide.none,
      label: label ?? Text('Label'),
      icon: icon ??
          Icon(
            Icons.not_interested,
            size: 28,
            color: Colors.teal,
          ),
      onPressed: onPressed ?? () => print('pressed type button'),
    );
  }
}
