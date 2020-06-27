import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:capslock/helpers/req_response.dart' as $request;
import 'package:capslock/app/app_core.dart';

class HTTPRequest {
  static final _log = Logger("HTTPRequest");

  Future<$request.ReqResponse> post(
      {String url, Map<String, String> headers, dynamic body}) async {
    final client = http.Client();
    final _response = $request.Response();

    final _url = '${AppCore.instance.restApiBaseUrl}$url';
    final _header = {
      'x-api-key': AppCore.instance.apiKey,
      'Content-Type': 'application/json'
    };
    if (headers != null) _header.addAll(headers);
    final _body = jsonEncode(body);

    try {
      final response = await client
          .post(_url, headers: _header, body: _body)
          .timeout(AppCore.httpTimeOut);

      final responseBody = json.decode(response.body);

      if (response.statusCode == $request.HTTPStatusCode.ok) {
        return _response.success($request.ResponseType.rest,
            $request.HTTPStatusCode.ok, [responseBody]);
      } else {
        return _response.error($request.ResponseType.rest, response.statusCode,
            data: [responseBody]);
      }
    } catch (e) {
      return _response.error($request.ResponseType.rest,
          $request.HTTPStatusCode.connectionRefused);
    } finally {
      client.close();
    }
  }

  Future<$request.ReqResponse> get(
      {String url, Map<String, String> headers}) async {
    final client = http.Client();
    final _response = $request.Response();

    final _url = '${AppCore.instance.restApiBaseUrl}$url';
    final _header = {
      'x-api-key': AppCore.instance.apiKey
    };
    if (headers != null) _header.addAll(headers);

    try {
      final response = await client
          .get(_url, headers: _header)
          .timeout(AppCore.httpTimeOut);

      final responseBody = json.decode(response.body);

      if (response.statusCode == $request.HTTPStatusCode.ok) {
        return _response.success($request.ResponseType.rest,
            $request.HTTPStatusCode.ok, [responseBody]);
      } else {
        return _response.error($request.ResponseType.rest, response.statusCode,
            data: [responseBody]);
      }
    } catch (e) {
      return _response.error($request.ResponseType.rest,
          $request.HTTPStatusCode.connectionRefused);
    } finally {
      client.close();
    }
  }
}
