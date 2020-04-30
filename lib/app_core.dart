import 'dart:async';

import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starter/user.dart';

class AppCore {
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

  Future<bool> get isUserAuthenticated => _isUserAuthenticated();
  Future<bool> _isUserAuthenticated() async {
    final AuthUser _authUser = await authUser;
    final bool isAuthenticated =
        _authUser != null && _authUser.token != null ?? false;
    return isAuthenticated;
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

  String get prefAuthUser => 'authUser';
}
