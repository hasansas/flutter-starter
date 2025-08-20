import '../models/user_model.dart';

class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'token': 'dummy.jwt.token',
      'user': {
        'id': '1',
        'name': 'John Doe',
        'email': email,
      }
    };
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return;
  }
}
