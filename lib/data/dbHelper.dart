import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:womenhealth/Model/user_diet.dart';

class DbHelper {
 Database? _db;

  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db!;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(),
        "userdiet.db"); // join ile path paketi bu yolu içine alıyor.
    var userDietDb = await openDatabase(dbPath, version: 1, onCreate: createDb);
    return userDietDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table calculateddiets(id integer primary key, calculation_date datetime, calories_taken float, calories_given float)");
  }

  Future<List<UserDiet>> getCalculatedDiets() async {
    Database db = await this.db;
    var result = await db.query("calculateddiets", columns: ['*']);

    return List.generate(result.length, (index) {
      return UserDiet.fromObject(result[index]);
    }
    );
  }


Future<int> insert(UserDiet userDiet) async {
  Database db = await this.db;
  var result = await db.insert("calculateddiets", userDiet.toMap());
  return result;
}

Future<int> delete(int id) async {
  Database db = await this.db;
  var result = await db.rawDelete("delete from calculateddiets where id = $id");
  return result;
}

Future<int> update(UserDiet userDiet) async {
  Database db = await this.db;
  var result = await db.update(
      "calculateddiets", userDiet.toMap(forFirebase: false), where: "id=?",
      whereArgs: [userDiet.id]);
  return result;
}
}
