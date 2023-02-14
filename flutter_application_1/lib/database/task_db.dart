import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDb {
  static const _databaseName = "TakApp.db";
  static const _databaseVersion = 1;

  TaskDb._internal();

  static final TaskDb databaseHelper = TaskDb._internal();
  static TaskDb get instance => databaseHelper;

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TASK (
      id INTEGER PRIMARY KEY,
      title TEXT NOT NULL,
      desc TEXT NOT NULL,
      status TEXT NOT NULL,
      lastUpdate TEXT NOT NULL,
      related TEXT,
      taskType TEXT NOT NULL,
      lastFilter TEXT)
      ''');
  }
}
