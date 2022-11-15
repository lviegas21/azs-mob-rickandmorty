// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_string_interpolations, unused_local_variable, prefer_adjacent_string_concatenation

import 'dart:convert';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request(
      {required String url,
      required String method,
      String? path,
      Map? body,
      Map? headers}) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});
    final jsonBody = body != null ? jsonEncode(body) : null;
    var response = Response('', 500);
    Future<Response>? futureResponse;
    var urlProd = url + path!;
    print(urlProd);
    try {
      if (method == 'post') {
        futureResponse = client.post(Uri.parse(urlProd),
            headers: defaultHeaders, body: jsonBody);
      } else if (method == 'get') {
        futureResponse =
            client.get(Uri.parse(urlProd), headers: defaultHeaders);
      } else if (method == 'put') {
        futureResponse = client.put(Uri.parse(urlProd),
            headers: defaultHeaders, body: jsonBody);
      }
      if (futureResponse != null) {
        response = await futureResponse.timeout(Duration(seconds: 10));
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    print(url);
    print(response.statusCode);
    print(response.body);
    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
