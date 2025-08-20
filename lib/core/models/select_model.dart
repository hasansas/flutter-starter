// lib/models/select_model.dart
class SelectModel {
  String? id;
  String? title;

  SelectModel({this.id, this.title});

  factory SelectModel.fromJson(Map<String, dynamic> json) {
    return SelectModel(id: json['id'], title: json['title']);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title};
  }
}
