import 'package:flutter/material.dart';
import 'package:starter/screens/home_screen.dart';
import 'package:starter/screens/login_screen.dart';
import 'package:starter/app_core.dart';
import 'package:logging/logging.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static final _log = Logger("MainScreen");

  void initState() {
    super.initState();
    AppCore.init(AppCore());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AppCore.instance.isUserAuthenticated,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            if (snapshot.data) return HomeScreen();
            return LoginScreen();
            break;
          default:
            return Text('splash screen');
        }
      },
    );
  }
}
