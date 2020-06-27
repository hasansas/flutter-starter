import 'dart:collection';
import 'package:flutter/foundation.dart';

class UserAuthProvider extends ChangeNotifier {
  Map<String, dynamic> _item;

  UnmodifiableMapView<String, dynamic> get item => UnmodifiableMapView(_item);

  void setAuthUser(Map<String, dynamic> item) {
    _item = item;
    notifyListeners();
  }

  void delete() {
    _item.clear();
    notifyListeners();
  }
}
