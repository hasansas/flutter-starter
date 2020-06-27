import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/app/preference_keys.dart';
import 'package:starter/user/models/user_auth_model.dart';

class AppCore extends ChangeNotifier {
  static final _log = Logger("AppCore");
  static AppCore _instance;

  static void init(AppCore inst) {
    if (_instance != null) {
      throw Exception("AppCore instance already initialized");
    }
    _instance = inst;
  }

  static AppCore get instance => _instance != null
      ? _instance
      : throw Exception("AppCore instance has not been initialized");

  // Is user authenticated
  var _isUserAuthenticated = false;
  bool get isUserAuthenticated => _isUserAuthenticated;

  // Auth user
  var _authUser = UserAuthModel(id: null, token: null);
  UserAuthModel get authUser => _authUser;

  Future<void> getUserAuthenticated() async {
    final _prefs = await SharedPreferences.getInstance();
    final _userData = _prefs.getStringList(PreferenceKeys.authUser);

    if (_userData != null) {
      const int id = 0;
      const int token = 1;
      final int userId = int.parse(_userData[id]) ?? null;
      final String userToken = _userData[token] ?? null;

      _authUser = UserAuthModel(id: userId, token: userToken);
      _isUserAuthenticated =
          _authUser != null && _authUser.token != null ?? false;
    }
  }

  // rest url
  String _restBaseUrl = 'http://192.168.43.105:8081/api';
  String get restApiBaseUrl => _restBaseUrl;

  // HTTP timeOut
  static const httpTimeOut = Duration(seconds: 20);

  // API key
  String _apiKey = 'ykskENutgECZxUarzmTPN2VDm3R53N5a';
  String get apiKey => _apiKey;

  // Authorization header
  String get httpAuthorizationHeaderValue => 'Bearer ${_authUser.token}';

  // Load environment
  Future<void> getEnv() async {
    await DotEnv().load('.env');
    _restBaseUrl = DotEnv().env['API_URL'];
    _apiKey = DotEnv().env['API_KEY'];
  }

  // Load state
  bool _stateLoaded = false;
  Future loadState() async {
    if (_stateLoaded) {
      return;
    }

    await getEnv();
    await getUserAuthenticated();

    _stateLoaded = true;
    _log.info("CoreStateLoaded");
  }

  @override
  void dispose() {
    super.dispose();
  }
}
