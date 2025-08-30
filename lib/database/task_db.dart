import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/task_model.dart';
import 'dart:io';

class TaskDB {
  static final TaskDB _instance = TaskDB._internal();
  factory TaskDB() => _instance;
  TaskDB._internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'tasks_db.sqlite');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tasks (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          notes TEXT,
          isDone INTEGER NOT NULL,
          createdAt INTEGER NOT NULL
        )
      ''');
    });
  }

  Future<int> insertTask(Task task) async {
    final database = await db;
    return await database.insert('tasks', task.toMap());
  }

  Future<int> updateTask(Task task) async {
    final database = await db;
    return await database.update('tasks', task.toMap(),
        where: 'id = ?', whereArgs: [task.id]);
  }

  Future<int> deleteTask(int id) async {
    final database = await db;
    return await database.delete('tasks', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Task>> getAllTasks() async {
    final database = await db;
    final res = await database.query('tasks', orderBy: 'createdAt DESC');
    return res.map((e) => Task.fromMap(e)).toList();
  }
}
