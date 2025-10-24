import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/logger.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/usecases/login_user.dart';
import '../../../auth/domain/usecases/logout_user.dart';
import '../../../auth/domain/usecases/get_auth_user.dart';

class AuthState {
  final User? user;
  final String? token;
  final bool loading;

  const AuthState({this.user, this.token, this.loading = false});

  AuthState copyWith({User? user, String? token, bool? loading}) {
    return AuthState(
      user: user ?? this.user,
      token: token ?? this.token,
      loading: loading ?? this.loading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final GetAuthUser getAuthUser;

  AuthNotifier({
    required this.loginUser,
    required this.logoutUser,
    required this.getAuthUser,
  }) : super(const AuthState());

  Future<void> login(String email, String password) async {
    state = state.copyWith(loading: true);
    try {
      final (token, user) = await loginUser(email, password);
      state = AuthState(user: user, token: token, loading: false);
    } catch (e, st) {
      Logger.error("Login failed", error: e, stackTrace: st);
      state = state.copyWith(loading: false);
    }
  }

  Future<void> logout() async {
    await logoutUser();
    state = const AuthState();
  }

  /// Called on startup
  Future<void> restoreSession() async {
    try {
      final (token, user) = await getAuthUser();
      if (token != null && user != null) {
        state = AuthState(user: user, token: token);
      }
    } catch (e) {
      Logger.error("Failed to restore session", error: e);
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  throw UnimplementedError("AuthProvider must be overridden");
});
