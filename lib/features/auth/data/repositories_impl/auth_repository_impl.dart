import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<(String, User)> login(String email, String password) async {
    final result = await remote.login(email, password);
    final token = result['token'] as String;
    final user = UserModel.fromJson(result['user']).toEntity();
    return (token, user);
  }

  @override
  Future<void> logout() => remote.logout();
}

extension on UserModel {
  User toEntity() => User(id: id, name: name, email: email);
}
