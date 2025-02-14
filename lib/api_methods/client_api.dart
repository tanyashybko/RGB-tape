import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../const.dart';

class ClientApi {
  final String apiUrl = baseUrl;

  Future<String?> post(String endpoint, Map<String, dynamic> data, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.post(url, headers: headers, body: jsonEncode(data));
    String responseBody = utf8.decoder.convert(response.bodyBytes);

    if (kDebugMode) {
      print('POST $endpoint - Status: ${response.statusCode}, Body: $responseBody');
    }

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<String?> get(String endpoint, {String? token}) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      if (token != null) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(url, headers: headers);
    String responseBody = utf8.decoder.convert(response.bodyBytes);

    if (kDebugMode) {
      print('GET $endpoint - Status: ${response.statusCode}, Body: $responseBody');
    }

    if (response.statusCode == 200) {
      return responseBody;
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> postRaw(String endpoint, String rawData) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final headers = {
      'Content-Type': 'text/plain',
    };

    final response = await http.post(url, headers: headers, body: rawData);
    String responseBody = utf8.decoder.convert(response.bodyBytes);

    if (kDebugMode) {
      print('POST $endpoint - Status: ${response.statusCode}, Body: $responseBody');
    }

    if (response.statusCode != 200) {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}
