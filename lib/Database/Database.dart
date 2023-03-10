import 'package:sqflite/sqflite.dart';
import 'package:untitled3/Database/database_model.dart';

class DatabaseHelper
{
  DatabaseHelper._internal();
  static DatabaseHelper instanse = DatabaseHelper._internal();

  final String tableName = 'Users';
  final String idColumn = 'id';
  final String userNameColumn = 'userName';
  final String emailColumn = 'email';
  late Database db;

  Future<Database> initDatabase() async
  {
    db =await openDatabase(
      'Users.db',version: 1,
      onCreate: (db, version)
      {
        db.execute(
            "CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY, $userNameColumn TEXT, $emailColumn TEXT)"
        ).then((value)
        {
          print('Database Created');
        });
      },
    );
    return db;
  }
  Future<int> insertIntoDatabase(Users user)async
  {
    return await db.insert(
      '$tableName',
      user.toMap(),
    );
  }
  Future<int> updateData(String newUserName,int? id) async
  {
   int newData = await db.update(
        '$tableName',
        {
          '$userNameColumn' : newUserName,
        },
      where: '$idColumn = ?',
        whereArgs: [id]
    );
   return newData;
  }
  Future<List<Users>> getDataFromDatabase() async
  {
   List<Map<String,dynamic>>users= await db.query(
        '$tableName',
      columns:
      [
        idColumn,
        userNameColumn,
        emailColumn,
      ],
    );
   return users.map((e) => Users.fromMap(e)).toList();
  }
  Future<List<Users>> search(String pattern)async
  {
    List<Map<String, dynamic>> filterUsers= await db.query(
      '$tableName',
      columns:
      [
        idColumn,
        userNameColumn,
        emailColumn,
      ],
      where: '$userNameColumn LIKE ?',
      whereArgs: ['%$userNameColumn%'],
    );
    return filterUsers.map((e) => Users.fromMap(e)).toList();
  }

  Future<int> deleteItem(int? id)async
  {
    return await db.delete(
        '$tableName',
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }


}