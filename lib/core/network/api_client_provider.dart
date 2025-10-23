import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/env_config.dart';
import 'api_client.dart';
import 'remote_config_service.dart';

/// Provides a fully initialized [ApiClient].
/// Handles baseUrl loading, API key injection, and token persistence automatically.
final apiClientProvider = FutureProvider<ApiClient>((ref) async {
  String baseUrl = EnvConfig.localBaseUrl;

  if (EnvConfig.isProduction) {
    try {
      final remoteConfig = RemoteConfigService();
      await remoteConfig.init();
      final remoteUrl = remoteConfig.getBaseUrl();
      if (remoteUrl.isNotEmpty) baseUrl = remoteUrl;
    } catch (_) {}
  }

  final apiClient = ApiClient(
    baseUrl: baseUrl,
    apiKey: EnvConfig.apiKey,
    onRefreshToken: (refreshToken) async {
      // implement refresh token logic here if needed
      // e.g. call /v1/auth/refresh
      return null;
    },
  );

  return apiClient;
});
