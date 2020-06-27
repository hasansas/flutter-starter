import 'package:flutter/material.dart';
import 'package:starter/app/app_localizations.dart';
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
}
