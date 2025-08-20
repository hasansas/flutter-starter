import 'dart:convert';
import 'package:http/http.dart' as http;
import '../error/app_exceptions.dart';

/// Simple API Client wrapper
class ApiClient {
  final String baseUrl;
  final http.Client _client;

  ApiClient({required this.baseUrl, http.Client? client})
      : _client = client ?? http.Client();

  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await _client.get(Uri.parse("$baseUrl$endpoint"));
    return _processResponse(response);
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse("$baseUrl$endpoint"),
      body: jsonEncode(body),
      headers: {"Content-Type": "application/json"},
    );
    return _processResponse(response);
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    final statusCode = response.statusCode;
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) return <String, dynamic>{};
      final decoded = jsonDecode(response.body);
      if (decoded is Map<String, dynamic>) return decoded;
      throw const ParsingException("Unexpected response shape");
    } else {
      throw NetworkException(
        "Request failed",
        details: "Status: $statusCode, Body: ${response.body}",
      );
    }
  }
}
