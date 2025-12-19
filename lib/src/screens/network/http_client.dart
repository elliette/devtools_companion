import 'dart:io' as io;

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'http_server.dart';

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
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending GET to $uri...');
    final request = await _client.getUrl(uri);
    networkNotifier('Sent GET.');
    final response = await request.close();
    networkNotifier('Received GET response: $response');
  }

  /// Sends an HTTP POST request using `dart:io`, and awaits a response.
  void post({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending POST to $uri...');
    final request = await _client.postUrl(uri);
    networkNotifier('Sent POST.');
    if (requestHasBody) {
      request.write('Request Body');
    }
    final response = await request.close();
    networkNotifier('Received POST response: $response');
  }

  /// Sends an HTTP PUT request using `dart:io`, and awaits a response.
  void put({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending PUT to $uri...');
    final request = await _client.putUrl(uri);
    networkNotifier('Sent PUT.');
    if (requestHasBody) {
      request.write('Request Body');
    }
    final response = await request.close();
    networkNotifier('Received PUT response: $response');
  }

  /// Sends an HTTP DELETE request using `dart:io`, and awaits a response.
  void delete({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending DELETE to $uri...');
    final request = await _client.deleteUrl(uri);
    networkNotifier('Sent DELETE.');
    if (requestHasBody) {
      request.write('Request Body');
    }
    final response = await request.close();
    networkNotifier('Received DELETE response: $response');
  }

  /// Sends an HTTP GET request using the http package, and awaits a response.
  void packageHttpGet({
    required Logger networkNotifier,
    // Unused.
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending package:http GET to $uri...');
    final response = await http.get(uri);
    networkNotifier('Received package:http GET response: ${response.body}');
  }

  /// Sends an HTTP POST request using the http package, and awaits a response.
  void packageHttpPost({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending package:http POST...');
    final response = await http.post(
      uri,
      body: requestHasBody ? {'name': 'doodle', 'color': 'blue'} : null,
    );
    networkNotifier('Received package:http POST response: ${response.body}');
  }

  /// Sends a streamed HTTP POST request using the http package, and awaits a
  /// response.
  void packageHttpPostStreamed({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending streamed package:http POST to $uri...');
    final request = http.StreamedRequest('POST', uri)
      ..contentLength = 20
      ..sink.add([11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
      ..sink.add([21, 22, 23, 24, 25, 26, 27, 28, 29, 30]);
    await request.sink.close();
    final response = await request.send();

    networkNotifier('Received package:http POST response: $response');
  }

  /// Sends an HTTP DELETE request using the http package, and awaits a
  /// response.
  void packageHttpDelete({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending package:http DELETE...');
    final response = await http.delete(
      uri,
      body: requestHasBody ? {'name': 'doodle', 'color': 'blue'} : null,
    );
    networkNotifier('Received package:http DELETE response: ${response.body}');
  }

  void dioGet({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending Dio GET to $uri...');
    // No body.
    final response = await _dio.getUri(uri);
    networkNotifier('Recived Dio GET response; headers: ${response.headers}');
  }

  void dioPost({
    required Logger networkNotifier,
    required bool requestHasBody,
    required bool responseHasBody,
    required int responseCode,
    bool shouldComplete = true,
  }) async {
    final uri = _computeUri(
      responseHasBody: responseHasBody,
      shouldComplete: shouldComplete,
      responseCode: responseCode,
    );
    networkNotifier('Sending Dio POST to $uri...');
    final response = await _dio.postUri(
      uri,
      data: requestHasBody ? {'a': 'b', 'c': 'd'} : null,
    );
    networkNotifier('Received Dio POST response: $response');
  }

  /// Computes a [Uri] from various configuration.
  ///
  /// The configuration is embedded into the URI, conveying the configuration to
  /// the HTTP server.
  Uri _computeUri({
    required bool responseHasBody,
    required bool shouldComplete,
    required int responseCode,
  }) => Uri.http(
    '127.0.0.1:$httpServerPort',
    [
      '/',
      if (responseHasBody) 'responseHasBody/',
      if (shouldComplete) 'complete/',
    ].join(),
    {'responseCode': '$responseCode'},
  );
}

typedef Logger = void Function(String);
