import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  final String displayName;
  final String displayImageUrl;

  User({this.id, this.displayName, this.displayImageUrl});

  factory User.fromJson(dynamic json) {
    return User(
      id: json['id'],
      displayName: json['display_name'],
      displayImageUrl: json['display_image_url'],
    );
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = this.id;
    map["display_name"] = this.displayName;
    map["display_image_url"] = this.displayName;

    return map;
  }
}

class AuthUser {
  final User userInfo;
  final String token;

  AuthUser({this.userInfo, this.token});
}
