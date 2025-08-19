import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<(String, User)> call(String email, String password) {
    return repository.login(email, password);
  }
}
