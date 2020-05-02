import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:logging/logging.dart';
import 'package:starter/app_core.dart';
import 'package:starter/app_localizations.dart';
import 'package:starter/settings/settings.dart';
import 'package:starter/home/ui/home_screen.dart';
import 'package:starter/login/ui/login_screen.dart';

class App extends StatefulWidget {
  App({Key key}) : super(key: key);

  static _AppState of(BuildContext context) =>
      context.findAncestorStateOfType<_AppState>();

  static _AppState state;

  @override
  State<StatefulWidget> createState() {
    if (state != null) {
      throw Exception("multiple instance of _AppState");
    }
    state = _AppState();
    return state;
  }
}

class _AppState extends State<App> {
  static final _log = Logger("App");

  void initState() {
    super.initState();

    // Core
    AppCore.init(AppCore());

    // Settings
    Settings.init(Settings());
    Settings.instance.addListener(this._onSettingsUpdated);
  }

  @override
  Widget build(BuildContext context) {
    _log.info("RunApp");
    final themeMode = Settings.instance.themeMode;
    return MaterialApp(
        title: 'Flutter Demo',
        theme:
            ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
        themeMode: themeMode,
        darkTheme: ThemeData(brightness: Brightness.dark),
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocaleLanguage in supportedLocales) {
            if (supportedLocaleLanguage.languageCode == locale.languageCode &&
                supportedLocaleLanguage.countryCode == locale.countryCode) {
              return supportedLocaleLanguage;
            }
          }
          // If device not support with locale to get language code then default get first on from the appSupportedLocales list
          return supportedLocales.first;
        },
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: appSupportedLocales
            .map((local) => Locale(local.languageCode, local.countryCode)),
        home: _buildHome(context));
  }

  Widget _buildHome(BuildContext context) {
    return FutureBuilder(
      future: _loadState(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            return AppCore.instance.isUserAuthenticated
                ? HomeScreen()
                : LoginScreen();
          default:
            return Text('splash');
        }
      },
    );
  }

  Future<void> _loadState() async {
    await AppCore.instance.loadState();
    await Settings.instance.loadState();
  }

  void _onSettingsUpdated() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();

    // Core
    AppCore.instance.dispose();

    // Settings
    Settings.instance.removeListener(this._onSettingsUpdated);
    Settings.instance.dispose();
  }
}
