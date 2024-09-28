// lib/db_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      return _initDatabase();
    }
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      await getDatabasesPath() + '/students.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
        db.execute(
          '''
          CREATE TABLE students(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            age INTEGER,
            course TEXT
          )
          ''',
        );
      },
    );
  }

  Future<List<String>> getTableNames() async {
    final db = await database;
    final result =
        await db.rawQuery('SELECT name FROM sqlite_master WHERE type="table"');
    List<String> tableNames =
        result.map((row) => row['name'] as String).toList();
    return tableNames;
  }

  Future<void> insertStudent(Map<String, dynamic> student) async {
    final db = await database;
    await db.insert('students', student,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return await db.query('students');
  }

  Future<void> updateStudent(Map<String, dynamic> student) async {
    final db = await database;
    await db.update(
      'students',
      student,
      where: 'id = ?',
      whereArgs: [student['id']],
    );
  }

  Future<void> deleteStudent(int id) async {
    final db = await database;
    await db.delete(
      'students',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getStudentCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) AS count FROM students');
    return result.first['count'] as int;
  }
}
