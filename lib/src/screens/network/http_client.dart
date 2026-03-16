import 'dart:async';
import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'http_server.dart';

/// The options for what the process should be after a request is sent; whether
/// the request should be completed by the server, or not, or cancelled by the
/// client.
enum CompletionType {
  completes('Completes'),
  doesNotComplete('Does not complete'),
  isCancelled('Is cancelled before completes');

  const CompletionType(this.text);

  final String text;
}

/// The HTTP client code that makes HTTP requests and logs various things.
class HttpClient {
  final io.HttpClient _client = io.HttpClient();

  final _dio = Dio();

  /// Sends an HTTP GET request using `dart:io`, and awaits a response.
  void get({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _ioRequest(
      method: 'GET',
      networkNotifier: networkNotifier,
      requestHasBody: requestHasBody,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      openRequest: (uri) => _client.getUrl(uri),
    );
  }

  /// Sends an HTTP POST request using `dart:io`, and awaits a response.
  void post({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _ioRequest(
      method: 'POST',
      networkNotifier: networkNotifier,
      requestHasBody: requestHasBody,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      openRequest: (uri) => _client.postUrl(uri),
    );
  }

  /// Sends an HTTP PUT request using `dart:io`, and awaits a response.
  void put({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _ioRequest(
      method: 'PUT',
      networkNotifier: networkNotifier,
      requestHasBody: requestHasBody,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      openRequest: (uri) => _client.putUrl(uri),
    );
  }

  /// Sends an HTTP DELETE request using `dart:io`, and awaits a response.
  void delete({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _ioRequest(
      method: 'DELETE',
      networkNotifier: networkNotifier,
      requestHasBody: requestHasBody,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      openRequest: (uri) => _client.deleteUrl(uri),
    );
  }

  /// Sends a request with the dart:io library as per the parameters.
  void _ioRequest({
    required String method,
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    required CompletionType completionType,
    required Future<io.HttpClientRequest> Function(Uri) openRequest,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      completionType: completionType,
      responseCode: responseCode,
    );
    networkNotifier('Sending $method to $uri...');
    final request = await openRequest(uri);
    networkNotifier('Sent $method.');
    if (requestHasBody) {
      request.write('Request Body');
    }
    if (completionType == CompletionType.isCancelled) {
      Timer(const Duration(seconds: 1), () {
        networkNotifier('$method aborted.');
        request.abort();
      });
    }
    try {
      final response = await request.close();
      networkNotifier('Received $method response: $response');
    } catch (e) {
      networkNotifier('$method caught exception: $e');
    }
  }

  /// Sends an HTTP GET request using the http package, and awaits a response.
  void packageHttpGet({
    required Logger networkNotifier,
    // Unused.
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _packageHttpRequest(
      method: 'GET',
      networkNotifier: networkNotifier,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      action: (client, uri) => client.get(uri),
    );
  }

  /// Sends an HTTP POST request using the http package, and awaits a response.
  void packageHttpPost({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _packageHttpRequest(
      method: 'POST',
      networkNotifier: networkNotifier,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      action: (client, uri) => client.post(
        uri,
        body: requestHasBody ? {'name': 'doodle', 'color': 'blue'} : null,
      ),
    );
  }

  /// Sends a streamed HTTP POST request using the http package, and awaits a
  /// response.
  void packageHttpPostStreamed({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _packageHttpRequest(
      method: 'streamed POST',
      networkNotifier: networkNotifier,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      action: (client, uri) async {
        final request = http.StreamedRequest('POST', uri)
          ..contentLength = 20
          ..sink.add([11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
          ..sink.add([21, 22, 23, 24, 25, 26, 27, 28, 29, 30]);
        await request.sink.close();
        return client.send(request);
      },
    );
  }

  /// Sends an HTTP DELETE request using the http package, and awaits a
  /// response.
  void packageHttpDelete({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _packageHttpRequest(
      method: 'DELETE',
      networkNotifier: networkNotifier,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      action: (client, uri) => client.delete(
        uri,
        body: requestHasBody ? {'name': 'doodle', 'color': 'blue'} : null,
      ),
    );
  }

  /// Sends a request with the http package as per the parameters.
  void _packageHttpRequest({
    required String method,
    required Logger networkNotifier,
    required bool responseHasBody,
    required int responseCode,
    required CompletionType completionType,
    required Future<dynamic> Function(http.Client, Uri) action,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      completionType: completionType,
      responseCode: responseCode,
    );
    networkNotifier('Sending package:http $method to $uri...');
    final client = http.Client();
    if (completionType == CompletionType.isCancelled) {
      Timer(const Duration(seconds: 1), () {
        networkNotifier('package:http $method client closed.');
        client.close();
      });
    }
    try {
      final response = await action(client, uri);
      networkNotifier('Received package:http $method response: $response');
    } catch (e) {
      networkNotifier('package:http $method caught exception: $e');
    } finally {
      client.close();
    }
  }

  void dioGet({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _dioRequest(
      method: 'GET',
      networkNotifier: networkNotifier,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      action: (cancelToken, uri) => _dio.getUri(uri, cancelToken: cancelToken),
    );
  }

  void dioPost({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    CompletionType completionType = CompletionType.completes,
  }) {
    _dioRequest(
      method: 'POST',
      networkNotifier: networkNotifier,
      responseHasBody: responseHasBody,
      responseCode: responseCode,
      completionType: completionType,
      action: (cancelToken, uri) => _dio.postUri(
        uri,
        data: requestHasBody ? {'a': 'b', 'c': 'd'} : null,
        cancelToken: cancelToken,
      ),
    );
  }

  /// Sends a request with the dio package as per the parameters.
  void _dioRequest({
    required String method,
    required Logger networkNotifier,
    required bool responseHasBody,
    required int responseCode,
    required CompletionType completionType,
    required Future<Response> Function(CancelToken, Uri) action,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      completionType: completionType,
      responseCode: responseCode,
    );
    networkNotifier('Sending Dio $method to $uri...');
    final cancelToken = CancelToken();
    if (completionType == CompletionType.isCancelled) {
      Timer(const Duration(seconds: 1), () {
        networkNotifier('Dio $method cancelled.');
        cancelToken.cancel('User cancelled request');
      });
    }
    try {
      final response = await action(cancelToken, uri);
      networkNotifier(
        'Recived Dio $method response; headers: ${response.headers}',
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        networkNotifier('Dio $method caught cancellation: ${e.message}');
      } else {
        networkNotifier('Dio $method caught DioException: $e');
      }
    } catch (e) {
      networkNotifier('Dio $method caught exception: $e');
    }
  }

  /// Computes a [Uri] from various configuration.
  ///
  /// The configuration is embedded into the URI, conveying the configuration to
  /// the HTTP server.
  Uri _computeUri({
    required bool responseHasBody,
    required CompletionType completionType,
    required int responseCode,
  }) => Uri.http(
    '127.0.0.1:$httpServerPort',
    [
      '/',
      if (responseHasBody) 'responseHasBody/',
      if (completionType ==
          CompletionType
              .completes /*||
          completionType == CompletionType.isCancelled*/ )
        'complete/',
    ].join(),
    {'responseCode': '$responseCode'},
  );
}

typedef Logger = void Function(String);
