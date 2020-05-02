import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app_core.dart';
import 'package:starter/login/ui/login_screen.dart';

class UserScreen extends StatelessWidget {
  static Route buildRoute() => MaterialPageRoute(builder: (_) => UserScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            FlatButton(
                child: Text('Logout'),
                onPressed: () {
                  logout(context);
                })
          ],
        ),
      ),
    );
  }

  void logout(BuildContext context) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.remove(AppCore.instance.prefAuthUser);

    Navigator.pushAndRemoveUntil(
        context, LoginScreen.buildRoute(), (route) => false);
  }
}
