import 'package:flutter/foundation.dart';

class UserModel with ChangeNotifier {
  final String id;
  final String displayName;
  final String displayImageUrl;

  UserModel({this.id, this.displayName, this.displayImageUrl});

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json['id'],
      displayName: json['display_name'],
      displayImageUrl: json['display_image_url'],
    );
  }
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = this.id;
    map["display_name"] = this.displayName;
    map["display_image_url"] = this.displayName;

    return map;
  }
}

class AuthUser {
  final UserModel userInfo;
  final String token;

  AuthUser({this.userInfo, this.token});
}
