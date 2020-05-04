import 'dart:async';
import 'package:login_flutter_local/model/User.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserDb {
  static const String TABLE = 'users';
  static const String COLUMN_EMAIL = 'email';
  static const String COLUMN_PASS = 'pass';
  static const String COLUMN_PROFILE = 'profile';

/* Investigar que hacen las dos siguientes lineas*/
  UserDb._();
  static final UserDb db = UserDb._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'userDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating user table");
        await database.execute(
          "CREATE TABLE $TABLE ("
          "$COLUMN_EMAIL TEXT PRIMARY KEY,"
          "$COLUMN_PASS TEXT,"
          "$COLUMN_PROFILE TEXT"
          ")",
        );
      },
    );
  }


// Funcionando User.db.autenticar(email
  Future<User> authenticator(String email, String pass) async {
    final db = await database;
   var userQuery =await  db.query(TABLE, where: "email = ? and pass= ?", whereArgs: [email, pass]);
   if (userQuery.isEmpty){
      return null;
   }else{
     return User.fromMap(userQuery.first);
   }
  }

// Funcionando User.db.getUserByEmail(email
  Future<User> getUserByEmail(String email) async {
    print("getting users");
    final db = await database;
   var userQuery =await  db.query(TABLE, where: "email = ?", whereArgs: [email]);
   if (userQuery.isEmpty){
      return null;
   }else{
     return User.fromMap(userQuery.first);
   }
  }

//Funcionando User.db.getUsers()
  Future<List<User>> getUsers() async {
    print("getting users");
    final db = await database;
    var users = await db
        .query(TABLE, columns: [COLUMN_EMAIL, COLUMN_PASS, COLUMN_PROFILE]);
    List<User> usersList = List<User>();
    users.forEach((currentUser) {
      User user = User.fromMap(currentUser);
      usersList.add(user);
    });
    return usersList;
  }

//Funcionando User.db.insertUser(user)
  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      TABLE,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//Funcionando User.db.deleteUser('email')
  Future<int> deleteUser(String email) async {
    final db = await database;
    return await db.delete(
      TABLE,
      where: "email = ?",
      whereArgs: [email],
    );
  }

//Funcionando User.db.updateUser(user')
  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update(
      TABLE,
      user.toMap(),
      where: "email = ?",
      whereArgs: [user.email],
    );
  }

  Future<void> grabarUsuario() async {
    User user =
        User(email: 'jsierra93@hotmail.com', profile: 'admin', pass: '1234');
    insertUser(user);
  }

  Future<void> buscarUsuario() async {
    getUserByEmail('jsierra93@hotmail.com').then((onValue){
      print(onValue);
    });
  }
}
