import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static final LocalDatabase instance = LocalDatabase._internal();

  static Database? _database;
  LocalDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _init();
    return _database!;
  }

  Future<Database> _init() async {
    String sql = '''CREATE TABLE saved_notes(
                      id INTEGER PRIMARY KEY AUTOINCREMENT,
                      author TEXT,
                      content TEXT,
                      date TEXT,
                      description TEXT,
                      imageUrl TEXT,
                      sourceName TEXT,
                      title TEXT,
                      url TEXT
                    ) ''';
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/news.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(sql);
      },
    );
  }
}
