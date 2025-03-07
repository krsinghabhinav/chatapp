import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._internal();

  static final DBHelper instance = DBHelper._internal();

  factory DBHelper() => instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      return _initDatabase();
    }
  }

  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, "userdata.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE UserData(
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         name TEXT NOT NULL,
         mobile TEXT NOT NULL,
         username TEXT NOT NULL
        )
        ''');
      },
    );
  }

  Future<int> insertData(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert("UserData", user,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> fetallData() async {
    Database db = await database;
    return await db.query("UserData");
  }
}
