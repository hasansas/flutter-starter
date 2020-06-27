class HTTPStatusCode {
  static const connectionRefused = 111;
  static const ok = 200;
  static const created = 201;
  static const noContent = 204;
  static const badRequest = 400;
  static const unauthorized = 401;
  static const forbidden = 403;
  static const notFound = 404;
  static const internalServerError = 500;
  static const notImplement = 501;
}

enum ResponseType { grpc, rest }

class ResponseMessage {
  final String title;
  final String description;

  ResponseMessage({this.title, this.description});

  factory ResponseMessage.fromJson(dynamic json) {
    return ResponseMessage(
        title: json['title'], description: json['description']);
  }
}

class ReqResponse {
  final bool success;
  final ResponseType type;
  final int code;
  final ResponseMessage message;
  final List data;

  ReqResponse({this.success, this.type, this.code, this.message, this.data});

  factory ReqResponse.fromJson(dynamic json) {
    final typeString = json['type'];
    final type =
        ResponseType.values.firstWhere((e) => e.toString() == typeString);
    return ReqResponse(
        success: json['success'],
        type: type,
        code: json['code'],
        message: json['message'],
        data: json['data']);
  }
}

class Response {
  ReqResponse success(ResponseType type, int code, List data) {
    return reqResponse(true, type, code, data);
  }

  ReqResponse error(ResponseType type, int code, {List data}) {
    return reqResponse(false, type, code, data ?? []);
  }

  ReqResponse reqResponse(
      bool success, ResponseType type, int code, List data) {
    final response = ReqResponse(
      success: success,
      type: type,
      code: code,
      message: message(type, code),
      data: data,
    );

    return response;
  }

  ResponseMessage message(ResponseType type, int code) {
    if (type == ResponseType.grpc) return grpcResponse(code);
    return httpResponse(code);
  }

  ResponseMessage httpResponse(int code) {
    final message = {
      HTTPStatusCode.connectionRefused: ResponseMessage(
          title: "Connection refused",
          description: "A network error occurred."),
      HTTPStatusCode.ok: ResponseMessage(
          title: "OK", description: "The request has succeeded."),
      HTTPStatusCode.created: ResponseMessage(
          title: "Created",
          description:
              "The request has succeeded and a new resource has been created as a result."),
      HTTPStatusCode.noContent: ResponseMessage(
          title: "No Content",
          description: "There is no content to send for this request."),
      HTTPStatusCode.badRequest: ResponseMessage(
          title: "Bad Request",
          description:
              "The server could not understand the request due to invalid syntax."),
      HTTPStatusCode.unauthorized: ResponseMessage(
          title: "Unauthorized",
          description:
              "The request does not have valid authentication credentials for the operation."),
      HTTPStatusCode.forbidden: ResponseMessage(
          title: "Forbidden",
          description:
              "The client does not have access rights to the content."),
      HTTPStatusCode.notFound: ResponseMessage(
          title: "Not Found",
          description: "The server can not find the requested resource."),
      HTTPStatusCode.internalServerError: ResponseMessage(
          title: "Internal Server Error",
          description: "Oops! Something went wrong. Please try again/"),
    };

    return message[code] ??
        ResponseMessage(title: "Unknown", description: "Unknown HTTP error!");
  }

  ResponseMessage grpcResponse(int code) {
    final message = {};

    return message[code] ??
        ResponseMessage(title: "Unknown", description: "Unknown HTTP error!");
  }
}
