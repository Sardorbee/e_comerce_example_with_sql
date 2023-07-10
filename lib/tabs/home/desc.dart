import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../sqflite/db.dart';
import 'data/data_list.dart';

// ignore: must_be_immutable
class DescriptionPage extends StatefulWidget {
  int? id;
  DescriptionPage({Key? key, this.id}) : super(key: key);

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final box = GetStorage();

  ProductSq? product;

  @override
  void initState() {
    super.initState();
    getProductById();
  }

  void getProductById() async {
    final fetchedProduct =
        await DatabaseHelper.getProductById(widget.id!.toInt());
    setState(() {
      product = fetchedProduct;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Product Description"),
            IconButton(
              onPressed: () async {
                if (product != null) {
                  ProductSq? onSSaved =
                      await DatabaseHelper.getProductById(product!.id!.toInt());

                  onSSaved!.onSaved == true;

                  await DatabaseHelper.updateProductById(
                      product!.id, onSSaved);

                  // ProductSq productt = ProductSq(
                  //     id: product!.id,
                  //     description: product!.description,
                  //     imagePath: product!.imagePath,
                  //     itemsCount: product!.itemsCount,
                  //     name: product!.name,
                  //     price: product!.price,
                  //     isLiked: product!.isLiked,
                  //     onSaved: product!.onSaved = true);
                  // await DatabaseHelper.updateProductById(
                  //     widget.id!.toInt(), productt);

                  print(product!.onSaved.toString());
                }
              },
              icon: Icon(Icons.save),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: product != null
                ? Image.asset(product!.imagePath.toString())
                : Container(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text('Name: '),
                      Text(
                        product?.name ?? '',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Price: '),
                      Text(
                        '${product?.price ?? ''} \$',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text('Description: '),
                      Text(
                        product?.description ?? '',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
