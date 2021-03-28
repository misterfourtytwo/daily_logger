import 'package:flutter/material.dart';

class FocusableButtonWidget extends StatefulWidget {
  FocusableButtonWidget({this.child, this.onPressed, Key key})
      : super(key: key);
  final Widget child;
  final VoidCallback onPressed;

  @override
  _FocusableButtonWidgetState createState() => _FocusableButtonWidgetState();
}

class _FocusableButtonWidgetState extends State<FocusableButtonWidget> {
  bool focus;
  bool hover;

  @override
  void initState() {
    super.initState();
    focus = false;
    hover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
              color: widget.onPressed == null
                  ? Colors.transparent
                  : hover || focus ? Colors.white70 : Colors.white30,
            ),
          ),
          type: MaterialType.card,
          borderOnForeground: true,
          clipBehavior: Clip.antiAlias,

          // animationDuration: Duration(seconds: 1),
          child: InkWell(
            onTap: widget.onPressed,
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
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
