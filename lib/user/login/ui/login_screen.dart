import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app/preference_keys.dart';
import 'package:starter/home/ui/home_screen.dart';
import 'package:starter/user/register/ui/register_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route buildRoute() => MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                child: Text('Login'),
                onPressed: () {
                  login(context);
                }),
            RaisedButton(
                child: Text('Register'),
                onPressed: () {
                  Navigator.push(context, RegisterScreen.buildRoute());
                }),
          ]),
    );
  }

  void login(BuildContext context) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setStringList(PreferenceKeys.authUser, ['1', 'token abc']);

    // go to home screen
    Navigator.pushReplacement(context, HomeScreen.buildRoute());
  }
}
