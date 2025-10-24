import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/user.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<(String, User)> login(String email, String password) async {
    final userModel = await remote.login(email, password);
    final token = remote.apiClient.accessToken ?? '';
    return (token, userModel.toEntity());
  }

  @override
  Future<void> logout() => remote.logout();

  @override
  Future<(String?, User?)> getAuthUser() async {
    final userModel = await remote.getAuthUser();
    final token = remote.apiClient.accessToken ?? '';
    return (token, userModel.toEntity());
  }
}

extension on UserModel {
  User toEntity() => User(id: id, name: name, email: email);
}
