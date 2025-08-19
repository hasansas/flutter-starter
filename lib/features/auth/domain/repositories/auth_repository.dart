import '../entities/user.dart';

abstract class AuthRepository {
  Future<(String, User)> login(String email, String password);
  Future<void> logout();
}
