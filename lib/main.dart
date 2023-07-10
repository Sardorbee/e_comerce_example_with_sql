import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:neww/sqflite/db.dart';
import 'package:neww/tabs/cart/cart_page.dart';
import 'package:neww/tabs/favourite/favourite_page.dart';
import 'package:neww/tabs/home/home_page.dart';
import 'package:neww/tabs/home/search_page.dart';
import 'package:neww/tabs/profile/profile_page.dart';

// import 'hive/product_adapter.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await DatabaseHelper.initializeDatabase();
  runApp(const MyApp());
  DatabaseHelper.instance;

  await GetStorage.init();
}

class MyApp extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const HomeScreen(),
    const CartPage(),
    const FavouritePage(),
    const ProfilePage(),
  ];
  final List<String> _appText = [
    "Products",
    "Cart",
    "Favourites",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appText[_currentIndex]),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ProductSearchDelegate(),
              );
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
      ),
      body: Center(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.blue,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedIconTheme: const IconThemeData(color: Colors.white),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "",
            ),
          ],
        ),
      ),
    );
  }
}
