import 'package:flutter/material.dart';
import '../../services/product_info.dart';

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
    _productInfoList = ItemListApi.fetchItemList();
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
                return ListTile(
                  title: Text(productInfo.name),
                  subtitle: Text(productInfo.description),
                  trailing: Text(productInfo.address),
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
