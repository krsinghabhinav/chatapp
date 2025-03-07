import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ApiDBHelper {
  // Private constructor for singleton pattern
  ApiDBHelper._internal();
  static final ApiDBHelper instance = ApiDBHelper._internal();

  factory ApiDBHelper() => instance;

  static Database? _database;

  // Singleton pattern to ensure only one instance of the database is created
  Future<Database> get database async {
    if (_database != null) {
      return _database!; // If the database is already created, return it
    } else {
      return await _initializeDatabase(); // Otherwise, initialize it
    }
  }

  // Initializing the database
  Future<Database> _initializeDatabase() async {
    String dbPath = await getDatabasesPath(); // Getting the database path
    String path =
        join(dbPath, 'apidataname.db'); // Defining the database name and path
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Creating the table on database creation
        await db.execute('''
        CREATE TABLE apidata(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          description TEXT,
          category TEXT,
          brand TEXT,
          warrantyInformation TEXT,
          shippingInformation TEXT,
          availabilityStatus TEXT
        )
        ''');
      },
    );
  }

  // Insert data into the table
  Future<int> insertData(Map<String, dynamic> insertData) async {
    var db = await database;
    return await db.insert(
      'apidata',
      insertData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Fetch all data from the table
  Future<List<Map<String, dynamic>>> fetchAllData() async {
    var db = await database;
    return await db.query("apidata");
  }

  // Check if a specific title exists in the database
  Future<bool> isSaved(String title) async {
    var db = await database;

    final List<Map<String, dynamic>> savedData = await db.query(
      "apidata",
      where: "title = ?",
      whereArgs: [title],
    );

    return savedData.isNotEmpty;
  }
}
