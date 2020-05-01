import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _PreferenceKeys {
  static const themeMode = "app.themeMode";
}

// Use SettingsChangeNotifier for Providers.
class Settings extends ChangeNotifier {
  static final _log = Logger("Settings");
  static Settings _instance;

  static void init(Settings inst) {
    if (_instance != null) {
      throw Exception("Settings instance already initialized");
    }
    _instance = inst;
  }

  static Settings get instance => _instance != null
      ? _instance
      : throw Exception("Settings instance has not been initialized");

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  set themeMode(ThemeMode value) {
    _storeThemeMode(value);
  }

  void _storeThemeMode(ThemeMode value) async {
    if (_themeMode == value) {
      return;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = value;
    await prefs.setInt(_PreferenceKeys.themeMode, _themeMode.index);
    notifyListeners();
  }

  // Load state
  bool _stateLoaded = false;
  Future loadState() async {
    if (_stateLoaded) {
      return;
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final themeModeIndex = prefs.getInt(_PreferenceKeys.themeMode);
    if (themeModeIndex != null) {
      final themeMode = ThemeMode.values[themeModeIndex];
      _themeMode = themeMode;
      notifyListeners();
    }

    _stateLoaded = true;
    _log.info("SettingStateLoaded");
  }

  @override
  void dispose() {
    _log.info("dispose");
    super.dispose();
  }
}
