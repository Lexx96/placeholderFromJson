import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Класс для работы с базой даных
class Db {
  /// Создание базы данных и получение соединения
  database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          "CREATE TABLE users (id INTEGER, name TEXT, username TEXT)",
        );
      },
    );
  }

  /// Метод добавляет запись в базу данных.
  /// Принимает название таблицы [tableName] и список полей модели [row]
  Future<void> insertRow(String tableName, dynamic row) async {
    final Database _db = await database();
    await _db.insert(
      tableName,
      row.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Метод проверяет существование записи.
  /// Принимает название таблицы [tableName] и id записи [idRow].
  Future<bool> readByID(String tableName, int idRow) async {
    final _db = await database();

    var result = await _db.query(tableName, where: "id = ?", whereArgs: [idRow]);
    return result.isEmpty ? false : true;
  }

  /// Выборка всех записей из таблицы.
  /// Принимает название таблицы [tableName]
  Future<List<dynamic>> readAll(String tableName) async {
    final _db = await database();
    return await _db.query(tableName);
  }

  /// Удаление всех записей из указанной таблицы [tableName]
  Future<void> deleteAllFromTable(String tableName) async {
    final _db = await database();
    await _db.rawDelete("delete from "+ tableName);
  }
}
