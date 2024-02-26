import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_drop/services/api_constants.dart';

class ProductInfo {
  final int id;
  final String category;
  final String title;
  final String description;
  final String product_image_data;
  final int user_id;

  ProductInfo({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.product_image_data,
    required this.user_id,
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
      user_id: json["user_id"],
    );
  }
}

final itemListProvider =
    FutureProvider.autoDispose<List<ProductInfo>>((ref) async {
  return await fetchData();
});

Future<List<ProductInfo>> fetchData(
    {String? category, String? searchKeyword}) async {
  final Uri uri = Uri.parse('${ApiConstants.BASE_URL}/product');
  final Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };
  final Map<String, String> queryParams = {};

  if (category != null) {
    queryParams['category'] = category;
  }

  if (searchKeyword != null) {
    queryParams['search'] = searchKeyword;
  }

  final Uri modifiedUri = uri.replace(queryParameters: queryParams);
  final response = await http.get(
    modifiedUri,
    headers: headers,
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((item) => ProductInfo.fromJson(item)).toList();
  } else {
    print(response.statusCode);
    throw Exception('Failed to load Item List');
  }
}
