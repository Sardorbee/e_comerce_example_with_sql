import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:like_button/like_button.dart';
import 'package:neww/sqflite/db.dart';
import '../login/login_page.dart';
import 'data/data_list.dart';
import 'desc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool isliked = false;
  final box = GetStorage();
  // List<bool> isLikedList = List.filled(productList.length, true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: FutureBuilder(
          future: DatabaseHelper.getProducts(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final products = snapshot.data;

              // return _buildContactList(contacts!, context);
              if (products.isEmpty) {
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
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    final currentProduct = products[index];
                    return Container(
                      margin: EdgeInsets.all(5),
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      // height: 40,
                      // width: 200,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      box.read("IsLoggedIn") == true
                                          ? DescriptionPage(
                                              id: currentProduct.id,
                                            )
                                          : const LoginPage(),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    color: Colors.blue,
                                  ),
                                  height: 100,
                                  width: 150,
                                  child: Image.asset(
                                      currentProduct.imagePath.toString()),
                                ),
                                Container(
                                  // height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                      children: [
                                        Text('Name: ${currentProduct.name}'),
                                        Row(
                                          children: [
                                            const Text('Price: '),
                                            Text(
                                              '${currentProduct.price} \$',
                                              style: const TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text('Last Price: '),
                                            Text(
                                              '${currentProduct.price - 15} \$',
                                              style: const TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                            'Description: ${currentProduct.description}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 50,
                              width: 50,
                              child: LikeButton(
                                key: ValueKey(currentProduct.isLiked),
                                size: 28,
                                circleColor: const CircleColor(
                                  start: Color(0xff00ddff),
                                  end: Color(0xff0099cc),
                                ),
                                bubblesColor: const BubblesColor(
                                  dotPrimaryColor: Color(0xff33b5e5),
                                  dotSecondaryColor: Color(0xff0099cc),
                                ),
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.favorite,
                                    color: isLiked ? Colors.red : Colors.white,
                                    size: 28,
                                  );
                                },
                                isLiked: currentProduct.isLiked,
                                onTap: (isLiked) async {
                                  ProductSq? issliked =
                                      await DatabaseHelper.getProductById(
                                          currentProduct.id);
                                  isLiked
                                      ? issliked!.isLiked == true
                                      : issliked!.isLiked == false;

                                  await DatabaseHelper.updateProductById(
                                      currentProduct.id,
                                      issliked);

                                  
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}
// 