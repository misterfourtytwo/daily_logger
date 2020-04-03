import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:daily_logger/services/log_provider.dart';
import 'package:daily_logger/ui/log_card.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class LogListWidget extends StatefulWidget {
  const LogListWidget({this.provider, Key key}) : super(key: key);
  final LogProvider provider;

  @override
  _LogListWidgetState createState() => _LogListWidgetState();
}

class _LogListWidgetState extends State<LogListWidget> {
  ItemScrollController _feedPositionController;
  ItemPositionsListener _feedPositionListener;

  LogProvider get provider => widget.provider;

  @override
  void initState() {
    _feedPositionController = ItemScrollController();
    _feedPositionListener = ItemPositionsListener.create();

    provider.addScroller('logListWidget', scrollTo);
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  void dispose() {
    provider.removeScroller('logListWidget');
    // _feedPositionController.dispose();
    // _feedPositionListener.itemPositions
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      itemScrollController: _feedPositionController,
      itemPositionsListener: _feedPositionListener,
      initialScrollIndex: max(1, provider.logs.length) - 1,
      itemCount: provider.logs.length,
      itemBuilder: (context, i) => provider.logs.isEmpty
          ? ListTile(title: Text('Log is empty'))
          : LogCardWidget(log: provider.logs[i]),
    );
  }

  void scrollTo(int element) {
    // print('scroll to element $element');
    if (_feedPositionController.isAttached &&
        !_feedPositionListener.itemPositions.value.contains(element)) {
      // print(_feedPositionListener.itemPositions);

      _feedPositionController.scrollTo(
          index: element,
          // alignment: 1,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOutCubic
          //
          );
      // print(_feedPositionListener.itemPositions);
    }
  }
}
