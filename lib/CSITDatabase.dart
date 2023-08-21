import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataBaseHandler {
  static Database? _database;

  //Singleton  Concept
  DataBaseHandler._privatecons();
  static final DataBaseHandler instance = DataBaseHandler._privatecons();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initDatabase();
      return _database!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'csit.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE mytable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> insertmodel(Model model) async {
    Database db = await instance.database;
    db.insert('mytable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> displaymodel() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query('mytable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> deletemodel(int id) async {
    Database db = await instance.database;
    db.delete('mytable', where: 'id= ?', whereArgs: [id]);
  }
}
