class UserAuthModel {
  final int id;
  final String token;

  UserAuthModel({this.id, this.token});

  factory UserAuthModel.fromJson(dynamic json) {
    return UserAuthModel(
      id: json['id'],
      token: json['token'],
    );
  }
  Map<String, dynamic> toJson() {
    var map = Map<String, dynamic>();
    map["token"] = this.token;
    map["id"] = this.id;

    return map;
  }
}
