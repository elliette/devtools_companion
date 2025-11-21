import 'dart:io' as io;

/// The HttpServer used for all HTTP requests.
class HttpServer {
  const HttpServer(this._server);

  final io.HttpServer _server;

  static Future<HttpServer> create() async {
    final ioServer = await io.HttpServer.bind(
      io.InternetAddress.loopbackIPv4,
      httpServerPort,
    );

    ioServer.listen((request) async {
      final path = request.uri.path;
      final queryParameters = request.uri.queryParameters;
      final responseCode =
          int.tryParse(queryParameters['responseCode'] ?? '200') ?? 200;
      request.response.statusCode = responseCode;
      if (path.contains('responseHasBody/')) {
        request.response.headers.contentType = io.ContentType(
          'application',
          'json',
          charset: 'utf-8',
        );
        request.response.write('{"response body":7}');
        await request.response.flush();
      }
      if (path.contains('complete/')) {
        await request.response.close();
      }
    });

    return HttpServer(ioServer);
  }

  /// The port that the [io.HttpServer] ultimately bound to.
  int get port => _server.port;
}

const httpServerPort = 8888;
