import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/user/user.dart';

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

  Future<void> getUserAuthenticated() async {
    final AuthUser _authUser = await authUser;
    _isUserAuthenticated =
        _authUser != null && _authUser.token != null ?? false;
  }

  Future<AuthUser> get authUser => _authUser();
  Future<AuthUser> _authUser() async {
    final _prefs = await SharedPreferences.getInstance();
    final _userData = _prefs.getStringList(prefAuthUser);

    if (_userData != null) {
      final int userDataLength = _userData.length;
      final int id = 0;
      final int displayName = 1;
      final int displayImageUrl = 2;
      final int token = 3;

      final String userid = userDataLength > token ? _userData[id] : null;
      final String userdisplayName =
          userDataLength > token ? _userData[displayName] : null;
      final String userdisplayImageUrl =
          userDataLength > token ? _userData[displayImageUrl] : null;
      final String userToken = userDataLength > token ? _userData[token] : null;

      User _userInfo = User(
          id: userid,
          displayName: userdisplayName,
          displayImageUrl: userdisplayImageUrl);

      AuthUser authUser = AuthUser(userInfo: _userInfo, token: userToken);
      return authUser;
    }
    return null;
  }

  // TODO: move to _PreferenceKeys
  String get prefAuthUser => 'authUser';

  // Load state
  bool _stateLoaded = false;
  Future loadState() async {
    if (_stateLoaded) {
      return;
    }

    await getUserAuthenticated();

    _stateLoaded = true;
    _log.info("CoreStateLoaded");
  }

  @override
  void dispose() {
    super.dispose();
  }
}
