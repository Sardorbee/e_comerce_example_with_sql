import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
    CREATE TABLE my_database(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      description TEXT,
      imagePath TEXT,
      price REAL,
      itemsCount INTEGER,
      isLiked INTEGER,
      onSaved INTEGER
    )
  ''');
  }

  static Future<int> insertProduct(ProductSq product) async {
    final db = await instance.database;
    return await db.insert('my_database', product.toMap());
  }

  static Future<int> deleteProduct(ProductSq product) async {
    final db = await instance.database;
    return await db.delete(
      'my_database',
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  static Future<int> deleteAllProducts() async {
    final db = await instance.database;
    return await db.delete('my_database');
  }

  static Future<List<ProductSq>> getProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('my_database');
    return List.generate(maps.length, (index) {
      return ProductSq(
          id: maps[index]['id'],
          name: maps[index]['name'],
          itemsCount: maps.first['itemsCount'],
          price: maps[index]['price'],
          description: maps[index]['description'],
          imagePath: maps[index]['imagePath'],
          isLiked: maps[index]['isLiked'] == 1,
          onSaved: maps[index]['onSaved'] == 1);
    });
  }

  static Future<ProductSq?> getProductById(int id) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'my_database',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return ProductSq(
        id: maps.first['id'],
        name: maps.first['name'],
        price: maps.first['price'],
        itemsCount: maps.first['itemsCount'],
        description: maps.first['description'],
        imagePath: maps.first['imagePath'],
        isLiked: maps.first['isLiked'] == 0,
        onSaved: maps.first['onSaved'] == 0,
      );
    }

    return null; // Return null if no product found
  }
  
  static Future<List<ProductSq>> getProductsBySearch(String query) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'my_database',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );
    return List.generate(maps.length, (index) {
      return ProductSq(
        id: maps[index]['id'],
        name: maps[index]['name'],
        itemsCount: maps[index]['itemsCount'],
        price: maps[index]['price'],
        description: maps[index]['description'],
        imagePath: maps[index]['imagePath'],
        isLiked: maps[index]['isLiked'] == 0,
        onSaved: maps[index]['onSaved'] == 0,
      );
    });
  }




  static Future<List<ProductSq>> getLikedProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'my_database',
      where: 'isLiked = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (index) {
      return ProductSq(
        id: maps[index]['id'],
        name: maps[index]['name'],
        itemsCount: maps[index]['itemsCount'],
        price: maps[index]['price'],
        description: maps[index]['description'],
        imagePath: maps[index]['imagePath'],
        isLiked: maps[index]['isLiked'] == 0,
        onSaved: maps[index]['onSaved'] == 0,
      );
    });
  }
  // 

  static Future<List<ProductSq>> getSavedProducts() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'my_database',
      where: 'onSaved = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (index) {
      return ProductSq(
        id: maps[index]['id'],
        name: maps[index]['name'],
        itemsCount: maps[index]['itemsCount'],
        price: maps[index]['price'],
        description: maps[index]['description'],
        imagePath: maps[index]['imagePath'],
        isLiked: maps[index]['isLiked'] == 0,
        onSaved: maps[index]['onSaved'] == 0,
      );
    });
  }









 static Future<int> updateProductById(int? id, ProductSq updatedProduct) async {
    final db = await instance.database;
    return await db.update(
      'my_database',
      updatedProduct.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteProductbyName(ProductSq product) async {
    final db = await instance.database;
    return await db.delete(
      'my_database',
      where: 'name = ?',
      whereArgs: [product.name],
    );
  }

  static Future<void> initializeDatabase() async {
    final db = await instance.database;
    final productList = [
      ProductSq(
        name: 'Laptop',
        price: 1200,
        itemsCount: 0,
        description: 'This is the description of product 1.',
        imagePath: 'assets/images/123.png',
        isLiked: false,
        onSaved: false,
      ),
      ProductSq(
        name: 'Headphone',
        price: 30,
        itemsCount: 0,
        description: 'This is the description of product 2.',
        imagePath: 'assets/images/headph.png',
        isLiked: false,
        onSaved: false,
      ),
      ProductSq(
        name: 'Phone',
        price: 485,
        itemsCount: 0,
        description: 'This is the description of product 3.',
        imagePath: 'assets/images/phone.png',
        isLiked: false,
        onSaved: false,
      ),
      ProductSq(
        name: 'Printer',
        price: 399,
        itemsCount: 0,
        description: 'This is the description of product 1.',
        imagePath: 'assets/images/printer.png',
        isLiked: false,
        onSaved: false,
      ),
      ProductSq(
        name: 'Smart Watch',
        price: 320,
        itemsCount: 0,
        description: 'This is the description of product 2.',
        imagePath: 'assets/images/swatch.png',
        isLiked: false,
        onSaved: false,
      ),
      ProductSq(
        name: 'Smart TV',
        price: 1150,
        itemsCount: 0,
        description: 'This is the description of product 2.',
        imagePath: 'assets/images/tv.png',
        isLiked: false,
        onSaved: false,
      ),
    ];

    for (final product in productList) {
      await db.insert('my_database', product.toMap());
    }
  }
}

class ProductSq {
  final int? id; // Add id field
  final String name;
  final String? description;
  final String? imagePath;
  final double price;
  int itemsCount;
  bool isLiked; // Add isLiked field
  bool onSaved; // Add isLiked field

  ProductSq({
    this.id,
    this.description,
    this.imagePath,
    required this.itemsCount,
    required this.name,
    required this.price,
    required this.isLiked,
    required this.onSaved,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Map id field
      'name': name,
      'price': price,
      'itemsCount': itemsCount,
      'description': description,
      'imagePath': imagePath,
      'isLiked': isLiked ? 1 : 0, // Map isLiked field
      'onSaved': onSaved ? 1 : 0, // Map isLiked field
    };
  }
}
