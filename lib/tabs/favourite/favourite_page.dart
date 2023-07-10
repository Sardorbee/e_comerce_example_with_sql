import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neww/sqflite/db.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final box = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        8,
      ),
      child: FutureBuilder(
        future: DatabaseHelper.getLikedProducts(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final productss = snapshot.data;

            if (productss.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/nothing_box.svg",
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "You have no products yet",
                      style: TextStyle(color: Colors.black38, fontSize: 16),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: productss.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = productss[index];
                  return Container(
                    margin: EdgeInsets.all(4),
                    padding: const EdgeInsets.all(20),
                    // height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(
                        20,
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset(product.imagePath.toString()),
                      title: Text(product.name),
                      trailing: TextButton(
                        onPressed: () async {
                          ProductSq? issliked =
                              await DatabaseHelper.getProductById(
                                  product.id!.toInt());
                          issliked!.isLiked == false;

                          await DatabaseHelper.updateProductById(
                              product.id, issliked);
                          setState(() {});
                        },
                        child: const Text(
                          "Unlike",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
              ;
            }
          }
        },
      ),
    );
  }
}
