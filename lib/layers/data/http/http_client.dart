abstract class HttpClient {
  Future<dynamic> request(
      {required String url, required String method, String path, Map? body});
}
