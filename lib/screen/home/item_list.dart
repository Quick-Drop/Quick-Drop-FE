import 'package:flutter/material.dart';
import 'item_bottom_modal.dart';
import '../../services/product_list_api.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Future<List<ProductInfo>> _productInfoList;
  String _selectedCategory = ''; // Track the selected category

  @override
  void initState() {
    super.initState();
    _productInfoList = ItemListApi.fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder<List<ProductInfo>>(
              future: _productInfoList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(
                    child: Text('Something went wrong'),
                  );
                } else {
                  final List<ProductInfo> productInfoList = snapshot.data!;
                  // Filter the list based on selected category
                  final filteredList = _selectedCategory.isEmpty
                      ? productInfoList
                      : productInfoList
                          .where((item) =>
                              item.category == _selectedCategory ||
                              _selectedCategory ==
                                  'All') // Include 'All' category
                          .toList();
                  return ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final productInfo = filteredList[index];
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
                                height:
                                    MediaQuery.of(context).size.height * 0.77,
                                child:
                                    ItemBottomModal(productInfo: productInfo),
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
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoryButton(String category) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedCategory = category; // Update the selected category
        });
      },
      child: Text(
        category,
        style: TextStyle(
            fontWeight: FontWeight.normal,
            color: _selectedCategory == category ? Colors.black : Colors.grey),
      ),
    );
  }
}
