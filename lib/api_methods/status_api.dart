// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import '../const.dart';
//
// class StatusApi {
//   static const String apiUrl = baseUrl;
//
//   Future<void> checkStatus() async {
//     final url = Uri.parse('$baseUrl/status');
//     final headers = {
//       'Content-Type': 'text/plain',
//     };
//
//     final response = await http.post(url, headers: headers);
//
//     if (response.statusCode == 200) {
//       if (kDebugMode) {
//         print('Server is up');
//       }
//     } else {
//       throw Exception('Failed to connect: ${response.statusCode}');
//     }
//   }
// }
