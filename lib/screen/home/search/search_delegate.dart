import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quick_drop/services/product_list_api.dart';

final searchQueryProvider = FutureProvider.autoDispose
    .family<List<ProductInfo>, String>((ref, query) async {
  if (query.isEmpty) {
    return [];
  } else {
    return await fetchData(searchKeyword: query);
  }
});

class ProductSearchDelegate extends SearchDelegate<ProductInfo?> {
  ProductSearchDelegate();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        : Consumer(builder: (context, ref, child) {
            final searchResultsAsync = ref.watch(searchQueryProvider(query));
            return searchResultsAsync.when(
              data: (results) {
                final filteredResults = results.where((productInfo) {
                  return productInfo.title
                      .toLowerCase()
                      .contains(query.toLowerCase());
                }).toList();
                return ListView.builder(
                  itemCount: filteredResults.length,
                  itemBuilder: (context, index) {
                    final item = filteredResults[index];
                    return ListTile(
                      title: Text(item.title),
                      onTap: () {
                        close(context, item);
                      },
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, __) => Text('Error: $error'),
            );
          });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }
}
