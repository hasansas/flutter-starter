import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:starter/app/app_core.dart';
import 'package:starter/user/models/user_auth_model.dart';
import 'package:starter/user/models/user_model.dart';
import 'package:starter/user/providers/user_provider.dart';
import 'package:starter/user/providers/user_auth_provider.dart';

class User {
  static final _log = Logger("User");
  final token = AppCore.instance.authUser.token;

  Future<UserModel> getAuthUser(BuildContext context,
      {int id, String userToken}) async {
    int _userId;
    UserModel _userModel;

    // token
    final _token = userToken ?? token;

    // get user from provider return if exists
    if (id != null) {
      _userId = id;
      _userModel = Provider.of<UserProvider>(context, listen: false)
          .getUser(userId: _userId);
      if (_userModel != null) return _userModel;
    }

    // init user
    _userModel = UserModel(
        id: _userId, name: 'Johnsas@domain.com', displayImageUrl: null);

    // save user to provider
    Provider.of<UserAuthProvider>(context, listen: false)
        .setAuthUser(UserAuthModel(id: _userId, token: _token).toJson());
    Provider.of<UserProvider>(context, listen: false).add(_userModel);

    return _userModel;
  }

  String getToken(BuildContext context) {
    if (token != null) return token;
    return Provider.of<UserAuthProvider>(context, listen: false)
            .item['token'] ??
        null;
  }
}
