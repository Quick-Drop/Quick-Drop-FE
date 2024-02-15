import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/product_list_api.dart'; // Import your product list API

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductInfo>>(
        future: ItemListApi.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final List<ProductInfo> products = snapshot.data!;
            final Map<String, List<ProductInfo>> productsByCategory = {};

            // Group products by category
            for (final product in products) {
              if (!productsByCategory.containsKey(product.category)) {
                productsByCategory[product.category] = [];
              }
              productsByCategory[product.category]!.add(product);
            }

            return ListView.builder(
              itemCount: productsByCategory.length,
              itemBuilder: (context, index) {
                final category = productsByCategory.keys.toList()[index];
                final List<ProductInfo>? categoryProducts =
                    productsByCategory[category];
                return ExpansionTile(
                  title: Text(category),
                  children: categoryProducts != null
                      ? categoryProducts.map((product) {
                          return ListTile(
                            title: Text(product.title),
                            subtitle: Text(product.description),
                          );
                        }).toList()
                      : [Text('No items in this category')],
                );
              },
            );
          }
        },
      ),
    );
  }
}
