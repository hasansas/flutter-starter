/// Base application exception
///
/// Provides a standard structure for all app-level exceptions.
/// Each exception includes a message, optional details, and an optional HTTP status code.
abstract class AppException implements Exception {
  final String message;
  final String? details;
  final int? statusCode;

  const AppException(this.message, {this.details, this.statusCode});

  /// Convert to JSON for logging, telemetry, or debugging
  Map<String, dynamic> toJson() => {
    'type': runtimeType.toString(),
    'message': message,
    if (details != null) 'details': details,
    if (statusCode != null) 'statusCode': statusCode,
  };

  @override
  String toString() {
    final buffer = StringBuffer('$runtimeType: $message');
    if (statusCode != null) buffer.write(' (HTTP $statusCode)');
    if (details != null && details!.isNotEmpty) buffer.write(' → $details');
    return buffer.toString();
  }
}

/// Thrown when a network request fails or cannot reach the server.
class NetworkException extends AppException {
  const NetworkException(String message, {String? details, int? statusCode})
    : super(message, details: details, statusCode: statusCode);
}

/// Thrown when response parsing or model mapping fails.
class ParsingException extends AppException {
  const ParsingException(String message, {String? details})
    : super(message, details: details);
}

/// Thrown when the request is unauthorized (HTTP 401).
class UnauthorizedException extends AppException {
  const UnauthorizedException(String message, {String? details})
    : super(message, details: details, statusCode: 401);
}

/// Thrown when access is forbidden (HTTP 403).
class ForbiddenException extends AppException {
  const ForbiddenException(String message, {String? details})
    : super(message, details: details, statusCode: 403);
}

/// Thrown when a requested resource is not found (HTTP 404).
class NotFoundException extends AppException {
  const NotFoundException(String message, {String? details})
    : super(message, details: details, statusCode: 404);
}

/// Thrown when the server returns a 5xx error.
class ServerException extends AppException {
  const ServerException(String message, {String? details, int? statusCode})
    : super(message, details: details, statusCode: statusCode ?? 500);
}

/// Thrown when the client sends an invalid or malformed request (HTTP 400).
class BadRequestException extends AppException {
  const BadRequestException(String message, {String? details})
    : super(message, details: details, statusCode: 400);
}

/// Thrown when a timeout occurs during the request.
class TimeoutException extends AppException {
  const TimeoutException(String message, {String? details})
    : super(message, details: details);
}

/// Thrown for unexpected or unknown errors.
class UnknownException extends AppException {
  const UnknownException(String message, {String? details, int? statusCode})
    : super(message, details: details, statusCode: statusCode);
}
