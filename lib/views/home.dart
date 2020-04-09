import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'package:daily_logger/services/log_provider.dart';
import 'package:daily_logger/widgets/create_log.dart';
import 'package:daily_logger/widgets/logs_list.dart';

final _sl = GetIt.instance;

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: ChangeNotifierProvider.value(
              value: _sl<LogProvider>(),
              child: Consumer<LogProvider>(
                  builder: (context, provider, child) => LogListWidget(
                        provider: provider,
                      )),
            )),
            // Container(height: 600, child:
            CreateLogWidget(size: MediaQuery.of(context).size),
          ],
        ),
      ),
    );
  }
}
