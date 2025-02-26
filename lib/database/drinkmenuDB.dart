import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:account/model/drinkmenuItem.dart';

class DrinkMenuDB {
  final String dbName;
  Database? _database;

  DrinkMenuDB({required this.dbName});

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE drinkmenu (
            keyID INTEGER PRIMARY KEY AUTOINCREMENT,
            drinkName TEXT NOT NULL,
            price REAL NOT NULL,
            category TEXT NOT NULL,
            dateAdded TEXT,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertDatabase(DrinkMenuItem drink) async {
    final db = await database;
    await db.insert('drinkmenu', drink.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<DrinkMenuItem>> loadAllData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('drinkmenu');

    return List.generate(maps.length, (i) {
      return DrinkMenuItem.fromMap(maps[i]);
    });
  }

  Future<void> updateData(DrinkMenuItem drink) async {
    final db = await database;
    await db.update(
      'drinkmenu',
      drink.toMap(),
      where: 'keyID = ?',
      whereArgs: [drink.keyID],
    );
  }

  Future<void> deleteData(DrinkMenuItem drink) async {
    final db = await database;
    await db.delete(
      'drinkmenu',
      where: 'keyID = ?',
      whereArgs: [drink.keyID],
    );
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('drinkmenu');
  }
}
