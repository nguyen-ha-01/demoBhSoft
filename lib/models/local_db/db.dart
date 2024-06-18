import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tiademo/models/category.dart';
import 'package:tiademo/models/task.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id TEXT PRIMARY KEY,
        label TEXT,
        description TEXT,
        time TEXT,
        state INTEGER,
        categoryId TEXT ,
        categoryName TEXT,
        categoryDes TEXT,
        categoryColorId INTEGER,
        categoryIconId  TEXT,
        priority INTEGER        
      )
    ''');

    await db.execute('''
      CREATE TABLE categories (
        id TEXT PRIMARY KEY,
        name TEXT,
        description TEXT,
        colorId INTEGER,
        iconId TEXT
      )
    ''');
    await db.execute('''
    CREATE TABLE cachedTask (
      id TEXT PRIMARY KEY,
        label TEXT,
        description TEXT,
        time TEXT,
        state INTEGER,
        categoryId TEXT ,
        categoryName TEXT,
        categoryDes TEXT,
        categoryColorId INTEGER,
        categoryIconId  TEXT,
        priority INTEGER ,
        action TEXT
    )''');
  }

  final String cacheTask = "cachedTask";
  final String UPDATE = "UPDATE";
  final String DELETE = "DELETE";

  Future<int?> insertTaskCache(Task task, String action) async {
    final db = await database;
    Map<String, dynamic> data = task.toMap();
    data.addAll({"action": action});
    return await db.insert(cacheTask, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getTaskCache() async {
    final db = await database;
    List<Map<String, dynamic>> out = [];
    var data = await db.query(cacheTask);
    out.addAll(data);
    return out;
  }

  Future<bool> deleteTaskCache(String id) async {
    final db = await database;
    try {
      await db.delete(
        cacheTask,
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<int?> insertTask(Task task) async {
    final db = await database;
    return await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task task) async {
    final db = await database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

  Future<bool> deleteTask(String id) async {
    final db = await database;
    try {
      await db.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<List<Task>> tasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<List<Task>> localTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tasks', where: 'id LIKE ?', whereArgs: ['LOCAL%']);

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  Future<int?> insertCategory(Category category) async {
    final db = await database;
    var r = await db.insert('categories', category.toMap(), conflictAlgorithm: ConflictAlgorithm.ignore);
    return r;
  }

  Future<List<Category>> categories() async {
    final db = await database;
    final List<Map<String, dynamic>> raw = await db.query('categories');
    return List.generate(raw.length, (i) {
      return Category.fromMap(raw[i]);
    });
  }

  Future<bool> deleteCategory(String id) async {
    final db = await database;
    try {
      await db.delete(
        'categories',
        where: 'id = ?',
        whereArgs: [id],
      );
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<List<Category>> localCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories', where: 'id LIKE ?', whereArgs: ['LOCAL%']);
    return List.generate(maps.length, (i) {
      return Category.fromMap(maps[i]);
    });
  }

  Future<List<Task>> getTaskByCategory(Category category) async {
    final db = await database;
    final List<Map<String, dynamic>> raw =
        await db.query('tasks', where: 'categoryId LIKE ?', whereArgs: [category.id]);
    if (raw.isNotEmpty) {
      return List.generate(raw.length, (i) {
        return Task.fromMap(raw[i]);
      });
    }
    return [];
  }

  Future<void> updateCategory(Category c) async {}
}
