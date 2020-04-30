import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app_core.dart';
import 'package:starter/screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  static Route buildRoute() => MaterialPageRoute(builder: (_) => HomeScreen());

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Container(
          margin: EdgeInsets.only(top: 50.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text('Welcome to App!'),
              FlatButton(
                  child: Text('Logout'),
                  onPressed: () {
                    logout(context);
                  })
            ],
          ),
        ),
      );

  void logout(BuildContext context) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(AppCore.instance.prefAuthUser);
    
    Navigator.pushAndRemoveUntil(
        context, LoginScreen.buildRoute(), (route) => false);
  }
}
