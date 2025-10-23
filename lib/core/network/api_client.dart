import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../error/app_exceptions.dart';

/// Simple, reusable API Client with:
/// - Automatic token persistence (SharedPreferences)
/// - Auto refresh-token retry
/// - Basic error mapping
class ApiClient {
  final String baseUrl;
  final String? apiKey;
  final http.Client _client;

  String? _accessToken;
  String? _refreshToken;

  /// Callback used to refresh tokens when access token expires (optional)
  final Future<String?> Function(String? refreshToken)? _onRefreshToken;

  ApiClient({
    required this.baseUrl,
    this.apiKey,
    http.Client? client,
    Future<String?> Function(String? refreshToken)? onRefreshToken,
  }) : _client = client ?? http.Client(),
       _onRefreshToken = onRefreshToken {
    _loadTokensFromStorage();
  }

  // ---------------------------------------------------------------------------
  //  Public HTTP Methods
  // ---------------------------------------------------------------------------

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _sendWithRetry(() {
      return _client.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: _buildHeaders(),
      );
    });
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await _sendWithRetry(() {
      return _client.post(
        Uri.parse('$baseUrl$endpoint'),
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
    });
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await _sendWithRetry(() {
      return _client.put(
        Uri.parse('$baseUrl$endpoint'),
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
    });
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> patch(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await _sendWithRetry(() {
      return _client.patch(
        Uri.parse('$baseUrl$endpoint'),
        headers: _buildHeaders(),
        body: jsonEncode(body),
      );
    });
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final response = await _sendWithRetry(() {
      return _client.delete(
        Uri.parse('$baseUrl$endpoint'),
        headers: _buildHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
    });
    return _processResponse(response);
  }

  // ---------------------------------------------------------------------------
  //  Token Handling & Retry Interceptor
  // ---------------------------------------------------------------------------

  Map<String, String> _buildHeaders() {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    if (apiKey != null) headers['x-api-key'] = apiKey!;
    if (_accessToken != null) headers['Authorization'] = 'Bearer $_accessToken';
    return headers;
  }

  Future<http.Response> _sendWithRetry(
    Future<http.Response> Function() requestFn,
  ) async {
    http.Response response = await requestFn();

    // Attempt token refresh once if unauthorized
    if (response.statusCode == 401 && _onRefreshToken != null) {
      final newToken = await _refreshAccessToken();

      if (newToken != null) {
        response = await requestFn(); // retry once
      }
    }

    return response;
  }

  Future<String?> _refreshAccessToken() async {
    if (_onRefreshToken == null || _refreshToken == null) return null;

    try {
      final newToken = await _onRefreshToken!(_refreshToken);
      if (newToken != null) {
        await updateTokens(accessToken: newToken);
      }
      return newToken;
    } catch (e) {
      await clearTokens();
      return null;
    }
  }

  // ---------------------------------------------------------------------------
  //  Token Persistence
  // ---------------------------------------------------------------------------

  Future<void> _loadTokensFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('accessToken');
    _refreshToken = prefs.getString('refreshToken');
  }

  Future<void> updateTokens({String? accessToken, String? refreshToken}) async {
    final prefs = await SharedPreferences.getInstance();
    if (accessToken != null) {
      _accessToken = accessToken;
      await prefs.setString('accessToken', accessToken);
    }
    if (refreshToken != null) {
      _refreshToken = refreshToken;
      await prefs.setString('refreshToken', refreshToken);
    }
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
    _accessToken = null;
    _refreshToken = null;
  }

  // ---------------------------------------------------------------------------
  //  Response Handling
  // ---------------------------------------------------------------------------

  Map<String, dynamic> _processResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};

      try {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) return decoded;
        throw const ParsingException('Unexpected response format');
      } catch (e) {
        throw ParsingException('Failed to parse response: $e');
      }
    }

    // Map status codes to AppExceptions
    switch (statusCode) {
      case 400:
        throw BadRequestException('Bad Request', details: response.body);
      case 401:
        throw UnauthorizedException('Unauthorized', details: response.body);
      case 403:
        throw ForbiddenException('Forbidden', details: response.body);
      case 404:
        throw NotFoundException('Not Found', details: response.body);
      default:
        if (statusCode >= 500) {
          throw ServerException(
            'Server error',
            statusCode: statusCode,
            details: response.body,
          );
        }
        throw NetworkException(
          'HTTP Error',
          statusCode: statusCode,
          details: response.body,
        );
    }
  }

  // ---------------------------------------------------------------------------
  //  Accessors
  // ---------------------------------------------------------------------------

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void dispose() => _client.close();
}
