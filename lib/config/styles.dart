import 'package:daily_logger/models/log_types.dart';
import 'package:flutter/material.dart';

class Styles {
  static BoxDecoration myBoxDecoration({
    BuildContext context,
    Color color,
    DecorationImage image,
    BoxBorder border,
    BorderRadiusGeometry borderRadius,
    List<BoxShadow> boxShadow,
    Gradient gradient,
    BoxShape shape,
    BlendMode backgroundBlendMode,
  }) {
    return BoxDecoration(
      color: color,
      image: image,
      border: border ??
          Border.all(
            color: Colors.white30,
            width: 3,
          ),
      borderRadius: borderRadius ?? BorderRadius.circular(8.0),
      boxShadow: boxShadow,
      gradient: gradient,
      shape: shape ?? BoxShape.rectangle,
      backgroundBlendMode: backgroundBlendMode,
    );
  }

  static InputDecoration myInputDecoration({
    bool isDense,
    String labelText,
    TextStyle labelStyle,
    Color hoverColor,
  }) {
    return InputDecoration(
      isDense: isDense ?? true,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white70, width: 3)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.white30, width: 3)),
      hoverColor: hoverColor,
      labelText: labelText ?? 'Label text',
      alignLabelWithHint: true,
      labelStyle: labelStyle ??
          TextStyle(
            color: Colors.white54,
          ),
    );
  }

  static final logTypeColors = {
    LogTypes.note: Colors.teal,
    LogTypes.payment: Colors.amber,
    LogTypes.task: Colors.blue,
    LogTypes.continuous: Colors.lightGreen[400],
  };

  static final logTypeIcons = {
    LogTypes.note: Icons.note,
    LogTypes.payment: Icons.attach_money,
    LogTypes.task: Icons.access_alarm,
    LogTypes.continuous: Icons.update,
  };
}
