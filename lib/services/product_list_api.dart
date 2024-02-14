import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quick_drop/services/api_constants.dart';

class ProductInfo with ChangeNotifier {
  final int id;
  final String category;
  final String title;
  final String description;
  final String product_image_data;

  ProductInfo({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.product_image_data,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') ||
        !json.containsKey('category') ||
        !json.containsKey('title') ||
        !json.containsKey('description')) {
      throw Exception('Invalid JSON data');
    }
    return ProductInfo(
      id: json["id"],
      category: json["category"],
      title: json["title"],
      description: json["description"],
      product_image_data: json["product_image_data"],
    );
  }
}

class ItemListApi with ChangeNotifier {
  static Future<List<ProductInfo>> fetchData() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.BASE_URL}/product'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ProductInfo.fromJson(item)).toList();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load Item List');
    }
  }
}
