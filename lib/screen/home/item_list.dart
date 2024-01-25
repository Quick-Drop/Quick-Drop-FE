import 'package:flutter/material.dart';
import 'package:quick_drop/screen/home/item_bottom_modal.dart';
import '../../services/product_info_api.dart';

class ItemList extends StatefulWidget {
  const ItemList({super.key});
  @override
  State<ItemList> createState() {
    return _ItemListState();
  }
}

class _ItemListState extends State<ItemList> {
  late Future<List<ProductInfo>> _productInfoList;
  @override
  void initState() {
    super.initState();
    _productInfoList = ItemListApi.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductInfo>>(
        future: _productInfoList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<ProductInfo> productInfoList = snapshot.data!;
            return ListView.builder(
              itemCount: productInfoList.length,
              itemBuilder: (context, index) {
                final productInfo = productInfoList[index];
                return InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            color: Colors.white,
                            child: const ItemBottomModal());
                      },
                    );
                  },
                  child: ListTile(
                    title: Text(productInfo.name),
                    subtitle: Text(productInfo.address),
                    trailing: const Icon(Icons.arrow_forward),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Sth went Wrong'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
