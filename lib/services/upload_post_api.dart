import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class UploadApi {
  static Future<void> sendPostRequest(Map<String, dynamic> requestData) async {
    try {
      var uri = Uri.parse('http://34.134.162.255:8000/donation/upload');
      var body = jsonEncode(requestData);

      var response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to upload data.');
      }
    } catch (e) {
      throw Exception('Error uploading data: $e');
    }
  }

  static Future<void> uploadImage(File image) async {
    try {
      var uri = Uri.parse('http://34.134.162.255:8000/image/test');
      var bytes = await image.readAsBytes();
      var imageData = base64Encode(bytes);

      var response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'data': imageData}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to upload image.');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }
}
