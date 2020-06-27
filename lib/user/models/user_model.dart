import 'package:logging/logging.dart';

class UserModel {
  static final _log = Logger("SelectProvince");
  int id;
  String name;
  String email;
  String displayImageUrl;

  UserModel(
      {this.id, this.name, this.email, this.displayImageUrl});

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      displayImageUrl: json['display_image']
    );
  }
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["id"] = this.id;
    map["name"] = this.name;
    map["email"] = this.email;
    map["display_image"] = this.displayImageUrl;

    return map;
  }
}