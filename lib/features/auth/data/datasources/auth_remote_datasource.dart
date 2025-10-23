import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';
import '../../../../core/error/app_exceptions.dart';

class AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSource(this.apiClient);

  /// Login user and persist tokens automatically via [ApiClient].
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiClient.post('/v1/auth/login/regular', {
        'identifier': email,
        'password': password,
      });

      final data = response['data'];
      if (data == null) throw const ParsingException('Missing data field');

      final accessToken = data['accessToken'] as String?;
      final refreshToken = data['refreshToken'] as String?;
      if (accessToken == null || refreshToken == null) {
        throw const ParsingException('Missing tokens in response');
      }

      // ApiClient handles token updates internally
      await apiClient.updateTokens(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      // Fetch user profile
      final user = await getProfile();
      return user;
    } on AppException {
      rethrow;
    } catch (e) {
      throw NetworkException('Login failed', details: e.toString());
    }
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await apiClient.get('/v1/users/me');
      final data = response['data'];

      if (data == null || data is! Map<String, dynamic>) {
        throw const ParsingException('Invalid user data format');
      }

      return UserModel.fromJson(data);
    } on AppException {
      rethrow;
    } catch (e) {
      throw ParsingException(
        'Failed to parse user profile',
        details: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await apiClient.clearTokens();
  }
}
