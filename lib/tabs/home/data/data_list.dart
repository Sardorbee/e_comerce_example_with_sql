// import 'package:hive/hive.dart';

class Product {
  final String imagePath;
  final String name;
  final double lastPrice;
  final double price;
  final String description;
   bool isLiked = false;

  Product(
      {required this.imagePath,
      required this.name,
      required this.lastPrice,
      required this.price,
      required this.description,
      isLiked = false});
}

List<Product> productList = [
  Product(
    imagePath: 'assets/images/123.png',
    name: 'Laptop',
    lastPrice: 900,
    price: 1200,
    description: 'This is the description of product 1.',
    isLiked: false
  ),
  Product(
    imagePath: 'assets/images/headph.png',
    name: 'Headphone',
    lastPrice: 25,
    price: 30,
    description: 'This is the description of product 2.',
  ),
  Product(
    imagePath: 'assets/images/phone.png',
    name: 'Phone',
    lastPrice: 450,
    price: 485,
    description: 'This is the description of product 3.',
    isLiked: false
  ),
  Product(
    imagePath: 'assets/images/printer.png',
    name: 'Printer',
    lastPrice: 350,
    price: 399,
    description: 'This is the description of product 1.',
    isLiked: false
  ),
  Product(
    imagePath: 'assets/images/swatch.png',
    name: 'Smart Watch',
    lastPrice: 299,
    price: 320,
    description: 'This is the description of product 2.',
    isLiked: false
  ),
  Product(
    imagePath: 'assets/images/tv.png',
    name: 'Smart TV',
    lastPrice: 999,
    price: 1150,
    description: 'This is the description of product 2.',
    isLiked: false
  ),
];
