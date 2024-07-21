import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart';
import '../models/orders.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('orders.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE orders(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      productId TEXT,
      productName TEXT,
      quantity INTEGER,
      price REAL,
      status TEXT
    )
    ''');
  }

  Future<int> insertOrder(Order order) async {
    final db = await instance.database;
    return await db.insert('orders', {
      'productId': order.product.uid,
      'productName': order.product.name,
      'quantity': order.quantity,
      'price': order.product.currentPrice,
      'status': order.status.toString().split('.').last,
    });
  }

  Future<List<Order>> getCompletedOrders() async {
    final db = await instance.database;
    final result =
        await db.query('orders', where: 'status = ?', whereArgs: ['completed']);
    return result
        .map((json) => Order(
              product: Product(
                uid: json['productId'] as String,
                name: json['productName'] as String,
                currentPrice: json['price'] as double,
                photos: [], // You might want to store photo URLs in the database as well
                status:
                    '', description: '', dateCreated: '', availableQuantity: 0, size: '', categories: [], // You might want to store product status in the database
              ),
              quantity: json['quantity'] as int,
              status: OrderStatus.completed,
            ))
        .toList();
  }
}
