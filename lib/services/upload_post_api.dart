import 'dart:convert';
import 'package:http/http.dart' as http;

class UploadPostApi {
  static Future<void> sendPostRequest(Map<String, dynamic> requestData) async {
    final response = await http.post(
      Uri.parse('http://34.134.162.255:8000/donation/upload'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create data.');
    }
  }
}
