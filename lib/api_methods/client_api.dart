import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../const.dart';

class ClientApi {
  final String apiUrl = baseUrl;

  Future<String?> post(String endpoint, Map<String, dynamic> data, {String? token}) async {
    return _sendRequest('POST', endpoint, body: jsonEncode(data), token: token);
  }

  Future<String?> get(String endpoint, {String? token}) async {
    return _sendRequest('GET', endpoint, token: token);
  }

  Future<void> postRaw(String endpoint, String rawData) async {
    await _sendRequest('POST', endpoint, body: rawData, contentType: 'text/plain');
  }

  Future<String?> _sendRequest(
      String method,
      String endpoint, {
        String? body,
        String? token,
        String contentType = 'application/json',
      }) async {
    final url = Uri.parse('$apiUrl$endpoint');
    final headers = {
      'Content-Type': contentType,
      if (token != null) 'Authorization': 'Bearer $token',
    };

    http.Response response;

    if (method == 'POST') {
      response = await http.post(url, headers: headers, body: body);
    } else if (method == 'GET') {
      response = await http.get(url, headers: headers);
    } else {
      throw Exception('The $method method is not supported');
    }

    String responseBody = utf8.decoder.convert(response.bodyBytes);

    if (kDebugMode) {
      print('$method $endpoint - Status: ${response.statusCode}, Body: $responseBody');
    }

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Request error: ${response.statusCode}');
    }
  }
}
