import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_drop/screen/home/item_bottom_modal.dart';
import 'package:quick_drop/services/product_list_api.dart';

final selectedCategoryProvider = StateProvider<String>((ref) => '');

final itemListProvider = FutureProvider.autoDispose<List<ProductInfo>>((ref) {
  final category = ref.watch(selectedCategoryProvider);
  return fetchData(
      category: category); // Replace with your actual fetchData function
});

class ItemList extends ConsumerStatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends ConsumerState<ItemList> {
  @override
  Widget build(BuildContext context) {
    final productInfoList = ref.watch(itemListProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCategoryButton('All'),
                  buildCategoryButton('Utensils'),
                  buildCategoryButton('Furniture'),
                  buildCategoryButton('Electronics'),
                  buildCategoryButton('Clothes'),
                  buildCategoryButton('Cosmetics'),
                  buildCategoryButton('Book'),
                  buildCategoryButton('Groceries'),
                  buildCategoryButton('e-ticket(mobile coupon)'),
                  buildCategoryButton('Etc'),
                ],
              ),
            ),
          ),
          Expanded(
            child: productInfoList.when(
              data: (productInfoList) {
                return ListView.builder(
                  itemCount: productInfoList.length,
                  itemBuilder: (context, index) {
                    final productInfo = productInfoList[index];
                    return InkWell(
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
                              height: MediaQuery.of(context).size.height * 0.77,
                              child: ItemBottomModal(
                                  productInfo:
                                      productInfo), // Replace with your actual ItemBottomModal widget
                            );
                          },
                        );
                      },
                      child: ListTile(
                        title: Text(productInfo.title),
                        subtitle: Text(productInfo.category),
                        trailing: const Icon(Icons.arrow_forward),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => const Center(
                child: Text('Something went wrong'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    return TextButton(
      onPressed: () {
        ref.watch(selectedCategoryProvider.notifier).state = category;
        ref.watch(itemListProvider);
      },
      child: Text(
        category,
        style: TextStyle(
          fontWeight: FontWeight.normal,
          color: selectedCategory == category ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
