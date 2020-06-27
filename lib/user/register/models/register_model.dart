class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String password;
  DateTime dob;

  RegisterModel({this.firstName, this.lastName, this.email, this.password});

  Map toJson() {
    Map map = Map();
    map["first_name"] = this.firstName;
    map["last_name"] = this.lastName;
    map["email"] = this.email;
    map["password"] = this.password;
    map["dob"] = this.dob;
    return map;
  }
}
