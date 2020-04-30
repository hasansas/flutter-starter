import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app_core.dart';
import 'package:starter/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static Route buildRoute() => MaterialPageRoute(builder: (_) => LoginScreen());

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: RaisedButton(
            child: Text('Login'),
            onPressed: () {
              login(context);
            }),
      ),
    );
  }

  void login(BuildContext context) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setStringList(
        AppCore.instance.prefAuthUser, ['id', 'name', 'image', 'token abc']);

    Navigator.pushReplacement(context, HomeScreen.buildRoute());
    // Navigator.pushAndRemoveUntil(
    //     context, HomeScreen.buildRoute(), (route) => false);
  }
}
