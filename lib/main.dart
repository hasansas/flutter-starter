import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:starter/app.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(App());
}
