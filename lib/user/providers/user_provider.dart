import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:starter/user/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  static final _log = Logger("UserProvider");
  final List<UserModel> _items = [];

  UnmodifiableListView<UserModel> get items => UnmodifiableListView(_items);

  void addAll(List<UserModel> items) {
    _items.clear();
    _items.addAll(items);
    notifyListeners();
  }

  void add(UserModel item, {int index}) {
    final data = _items.firstWhere((element) => element.id == item.id,
        orElse: () => null);
    if (data == null) {
      if (index != null) {
        _items.insert(index, item);
      } else {
        _items.add(item);
      }
      notifyListeners();
    }
  }

  void delete(int id) {
    _items.removeWhere((data) => data.id == id);
    notifyListeners();
  }

  void update(int id, UserModel user) {
    final data =
        _items.firstWhere((element) => element.id == id, orElse: () => null);

    data.name = user.name ?? data.name;
    data.email = user.email ?? data.email;
    data.displayImageUrl = user.displayImageUrl ?? data.displayImageUrl;
    notifyListeners();
  }

  UserModel getUser({int userId}) {
    final data = _items.firstWhere((element) => element.id == userId,
        orElse: () => null);
    return data;
  }
}
