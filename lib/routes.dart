import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/profile/presentation/pages/profile_page.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const profile = '/profile';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomePage(),
      login: (context) => const LoginPage(),
      profile: (context) => const ProfilePage(),
    };
  }
}
