// lib/features/auth/domain/usecases/get_auth_user.dart

import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class GetAuthUser {
  final AuthRepository repository;

  GetAuthUser(this.repository);

  Future<(String?, User?)> call() async {
    return await repository.getAuthUser();
  }
}
