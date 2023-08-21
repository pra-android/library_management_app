import 'dart:async';
import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BITDataBaseHandler {
  static Database? _bitdatabase;

  //Singleton  Concept
  BITDataBaseHandler._privatecons();
  static final BITDataBaseHandler instance = BITDataBaseHandler._privatecons();

  Future<Database> get bitdatabase async {
    if (_bitdatabase != null) {
      return _bitdatabase!;
    } else {
      _bitdatabase = await initDatabase();
      return _bitdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bit.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bittable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> bitinsertmodel(Model model) async {
    Database db = await instance.bitdatabase;
    db.insert('bittable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bitdisplaymodel() async {
    Database db = await instance.bitdatabase;
    List<Map<String, dynamic>> maps = await db.query('bittable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bitdeletemodel(int id) async {
    Database db = await instance.bitdatabase;
    db.delete('bittable', where: 'id= ?', whereArgs: [id]);
  }
}
