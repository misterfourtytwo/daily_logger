import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:daily_logger/services/log_provider.dart';
import 'package:daily_logger/ui/log_card.dart';
import 'package:daily_logger/utils/date_extensions.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePositionedList.builder(
      initialScrollIndex: max(1, provider.logs.length) - 1,
      itemCount: provider.logs.length,
      // reverse: true,
      // physics: FixedExtentScrollPhysics(),
      itemBuilder: (context, i) => provider.logs.isEmpty
          ? ListTile(title: Text('Log is empty'))
          : LogCardWidget(
              log: provider.logs[i],
              showDate: i == 0 ||
                  !provider.logs[i].date
                      .sameDateWith(provider.logs[i - 1].date)),
      itemScrollController: _feedPositionController,
      itemPositionsListener: _feedPositionListener,
    );
  }

  void scrollTo(int element) {
    // adding callback, so we won't try scrolling before items are added to the list.
    WidgetsBinding.instance.scheduleFrameCallback((timeStamp) {
      if (_feedPositionController.isAttached)
        print('scroll to element $element');
      {
        final target = _feedPositionListener.itemPositions.value
            .firstWhere((e) => e.index == element, orElse: () => null);
        // print(target);

        // check if item is already on the screen
        if (target == null ||
            target.itemLeadingEdge < 0 ||
            target.itemTrailingEdge > 1.0) {
          _feedPositionController.scrollTo(
              index: element,
              duration: Duration(seconds: 1),
              curve: Curves.easeInOutCubic
              //
              );
        }
      }
    });
  }
}
