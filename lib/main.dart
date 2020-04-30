import 'package:flutter/material.dart';
import 'package:starter/screens/main_screen.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(App());
}

class App extends StatelessWidget {    

  @override
  Widget build(BuildContext context) {
    // AppCore.init(AppCore());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainScreen(title: 'Flutter Demo Home Page'),
    );
  }
}
