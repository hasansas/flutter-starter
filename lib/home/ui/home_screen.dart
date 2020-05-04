import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app_core.dart';
import 'package:starter/app_localizations.dart';
import 'package:starter/user/login/ui/login_screen.dart';
import 'package:starter/home/ui/home_bar_actions.dart';

class HomeScreen extends StatelessWidget {
  static Route buildRoute() => MaterialPageRoute(builder: (_) => HomeScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home'), actions: homeBarActions(context)),
      body: Container(
        margin: EdgeInsets.only(top: 50.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Text(AppLocalizations.of(context).text('hello')),
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
