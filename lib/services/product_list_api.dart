import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductInfo with ChangeNotifier {
  final int id;
  final String name;
  final String title;
  final String description;
  final String address;

  ProductInfo({
    required this.id,
    required this.name,
    required this.title,
    required this.description,
    required this.address,
  });

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id') ||
        !json.containsKey('name') ||
        !json.containsKey('title') ||
        !json.containsKey('description') ||
        !json.containsKey('address')) {
      throw Exception('Invalid JSON data');
    }
    return ProductInfo(
      id: json["id"],
      name: json["name"],
      title: json["title"],
      description: json["description"],
      address: json["address"],
    );
  }
}

class ItemListApi with ChangeNotifier {
  static Future<List<ProductInfo>> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://c0d37d40-3638-49a9-942b-3fb838191686.mock.pstmn.io/list'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ProductInfo.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load Item List');
    }
  }
}
