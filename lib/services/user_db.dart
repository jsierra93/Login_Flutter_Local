import 'dart:async';
import 'package:login_flutter_local/model/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDb {
  var database;
  static const String table = 'users';

  void inicializar() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'login_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(email INTEGER PRIMARY KEY, pass TEXT, profile TEXT)",
        );
      },
      version: 1,
    );
  }
 Future<void> insertUser(User user) async {
    final Database db = await database;
    await db.insert(
      table,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  
  Future<List<User>> allUsers() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return User(
        email: maps[i]['email'],
        pass: maps[i]['pass'],
        profile: maps[i]['profile'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    final db = await database;

    await db.update(
      table,
      user.toMap(),
      where: "email = ?",
      whereArgs: [user.email],
    );
  }

  Future<void> deleteUser(String email) async {
    final db = await database;

    await db.delete(
      table,
      where: "email = ?",
      whereArgs: [email],
    );
  }

}
