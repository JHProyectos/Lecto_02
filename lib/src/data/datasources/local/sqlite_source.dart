//lib/src/data/datasources/remote/sqlite_source.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('lecto.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        name TEXT,
        email TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE pdfs(
        id TEXT PRIMARY KEY,
        name TEXT,
        path TEXT,
        userId TEXT,
        FOREIGN KEY (userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE audios(
        id TEXT PRIMARY KEY,
        name TEXT,
        path TEXT,
        pdfId TEXT,
        FOREIGN KEY (pdfId) REFERENCES pdfs(id)
      )
    ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Implementar lógica para futuras migraciones.
    }
  }

  Future<int> insert(String table, Map<String, dynamic> data) async {
    try {
      final db = await database;
      return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (e) {
      print('Error inserting data: $e');
      return -1; // Indicar error
    }
  }

  Future<List<Map<String, dynamic>>> query(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> data) async {
    try {
      final db = await database;
      return await db.update(
        table,
        data,
        where: 'id = ?',
        whereArgs: [data['id']],
      );
    } catch (e) {
      print('Error updating data: $e');
      return -1;
    }
  }

  Future<int> delete(String table, String id) async {
    try {
      final db = await database;
      return await db.delete(
        table,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      print('Error deleting data: $e');
      return -1;
    }
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
    }
  }
}
