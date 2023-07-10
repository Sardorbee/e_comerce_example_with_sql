import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neww/sqflite/db.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int currentNumber = 0;
  int result = 0;
  void addNumber() {
    currentNumber++;
    result = currentNumber;
  }

  void subtractNumber() {
    currentNumber--;
    result = currentNumber;
  }

  Future readData() async {
    await DatabaseHelper.getProducts();
  }

  // bool isVisible = false;
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await DatabaseHelper.deleteAllProducts();
        setState(() {});
      }),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<ProductSq>>(
          future: DatabaseHelper.getSavedProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ProductSq> products = snapshot.data!;
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  ProductSq product = products[index];
                  return Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      leading: Image.asset(product.imagePath.toString()),
                      title: Text(product.name),
                      subtitle: Text(product.description ?? ''),
                      trailing: Container(
                        width: 150,
                        child: Row(
                          children: [
                            TextButton(
                                onPressed: () async {
                                  ProductSq productt = ProductSq(
                                      id: product.id,
                                      description: product.description,
                                      imagePath: product.imagePath,
                                      itemsCount: product.itemsCount > 0
                                          ? product.itemsCount - 1
                                          : product.itemsCount,
                                      name: product.name,
                                      price: product.price,
                                      isLiked: product.isLiked,
                                      onSaved: product.onSaved = true);
                                  await DatabaseHelper.updateProductById(
                                      product.id, productt);
                                  setState(() {});
                                },
                                child: const Text(
                                  '-',
                                  style: TextStyle(fontSize: 24),
                                )),
                            Text(
                              product.itemsCount.toString(),
                              style: TextStyle(fontSize: 24),
                            ),
                            TextButton(
                                onPressed: () async{
                                  ProductSq productt = ProductSq(
                                      id: product.id,
                                      description: product.description,
                                      imagePath: product.imagePath,
                                      itemsCount: product.itemsCount >= 0
                                          ? product.itemsCount + 1
                                          : product.itemsCount,
                                      name: product.name,
                                      price: product.price,
                                      isLiked: product.isLiked,
                                      onSaved: product.onSaved= true);
                                  await DatabaseHelper.updateProductById(
                                      product.id, productt);
                                  setState(() {});
                                },
                                child: const Text(
                                  '+',
                                  style: TextStyle(fontSize: 24),
                                )),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}


// box.read("ProductImagePath") != null
//                 ? Container(
//                     height: 100,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(
//                         20,
//                       ),
//                     ),
//                     padding: EdgeInsets.all(8),
//                     // visible: isVisible,
//                     child: ListTile(
//                       leading: Image.asset(box.read("ProductImagePath")),
//                       title: Text(box.read("ProductName")),
//                       trailing: Text(box.read("ProductPrice").toString()),
//                     ),
//                   )
//                 : Container(
//                     padding: EdgeInsets.all(25),
//                     child: const Center(
//                         child: Text(
//                             style: TextStyle(fontSize: 20),
//                             "You didn't save any product for cart")),
//                   ),