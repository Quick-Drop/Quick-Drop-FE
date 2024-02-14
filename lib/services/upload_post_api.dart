import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quick_drop/services/api_constants.dart';

class UploadApi {
  static Future<void> sendPostRequest(Map<String, dynamic> requestData) async {
    try {
      var uri = Uri.parse('${ApiConstants.BASE_URL}/donation/upload');
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

  static Future<String> uploadImageAndGetCategory(File image) async {
    try {
      var uri = Uri.parse('${ApiConstants.BASE_URL}/classify');
      var bytes = await image.readAsBytes();
      var imageData = base64Encode(bytes);

      var response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'data': imageData}),
      );

      if (response.statusCode == 200) {
        return response.body; // Return category text
      } else {
        throw Exception('Failed to upload image.');
      }
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  static String extractCategoryText(String responseText) {
    String categoryText = responseText.replaceAll(
        RegExp(r'[^\w\s]'), ''); // Remove non-word characters
    if (categoryText.contains(':')) {
      categoryText = categoryText.split(':')[1].trim();
    } // Remove leading and trailing whitespace
    return categoryText;
  }
}
