import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductInfo with ChangeNotifier {
  final int id;
  final String category;
  final String title;
  final String description;

  ProductInfo({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
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
    );
  }
}

class ItemListApi with ChangeNotifier {
  static Future<List<ProductInfo>> fetchData() async {
    final response = await http.get(
      Uri.parse('http://34.134.162.255:8000/product'),
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
