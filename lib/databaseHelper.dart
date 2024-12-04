import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // 私有构造函数，禁止外部创建实例
  DatabaseHelper._privateConstructor();
  // 单例实例
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  // 获取数据库实例
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDatabase();
    }
    return _database!;
  }

  // 初始化数据库
  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'math_problems.db');
    return openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE problems (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            problem TEXT,
            answer TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  // 插入题目到数据库
  Future<void> insertProblem(String problem, String answer) async {
    final db = await database;
    await db.insert(
      'problems',
      {'problem': problem, 'answer': answer},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 查询所有问题
  Future<List<Map<String, dynamic>>> getAllProblems() async {
    final db = await database;
    return await db.query('problems');
  }
}

