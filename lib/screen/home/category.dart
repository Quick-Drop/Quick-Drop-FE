import 'package:flutter/material.dart';
import 'package:quick_drop/screen/home/item_bottom_modal.dart';
import '../../services/product_list_api.dart'; // Import your product list API
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Category extends ConsumerWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FutureBuilder<List<ProductInfo>>(
        future: ref.watch(itemListProvider.future),
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
                            onTap: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child:
                                        ItemBottomModal(productInfo: product),
                                  );
                                },
                              );
                            },
                          );
                        }).toList()
                      : [const Text('No items in this category')],
                );
              },
            );
          }
        },
      ),
    );
  }
}
