import 'package:flutter/material.dart';
import 'package:neww/tabs/home/data/data_list.dart';

import '../../sqflite/db.dart';

class ProductSearchDelegate extends SearchDelegate<ProductSq> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
   Map search = DatabaseHelper.getProductsBySearch(query) as Map;
   

    return FutureBuilder<List<ProductSq>>(
      future: DatabaseHelper.getProductsBySearch(query),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final searchResults = snapshot.data!;
          print(searchResults);
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final product = searchResults[index];
              return ListTile(
                title: Text(product.name),
                onTap: () {
                  close(context, product);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Retrieve search suggestions based on query
    return SizedBox();
  }
}
