import 'package:restaurant_app/data/model/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblRestaurants = 'restaurants';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/newsapp.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblRestaurants (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating DECIMAL(2,1)
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertRestaurant(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tblRestaurants, restaurant.toJson());
  }

  Future<List<Restaurant>> getRestaurants() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblRestaurants);

    return results.map((res) => Restaurant.fromJson(res)).toList();
  }

  Future<Map> getRestaurantsById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblRestaurants,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeRestaurant(String id) async {
    final db = await database;

    await db!.delete(
      _tblRestaurants,
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}