import 'package:flutter_application_1/database/task_db.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MockDb extends Mock implements TaskDb {
  static Database? _database;

  MockDb._internal();

  static final databaseHelper = MockDb._internal();
  static MockDb get instance => databaseHelper;

  @override
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiNoIsolate;
    return await openDatabase(inMemoryDatabasePath,
        version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TASK (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      desc TEXT NOT NULL,
      status TEXT NOT NULL,
      lastUpdate TEXT NOT NULL,
      related TEXT,
      taskType TEXT NOT NULL,
      lastFilter TEXT,
      image TEXT)
      ''');
  }
}
