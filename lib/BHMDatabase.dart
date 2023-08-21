import 'dart:async';
import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BHMDataBaseHandler {
  static Database? _bhmdatabase;

  //Singleton  Concept
  BHMDataBaseHandler._privatecons();
  static final BHMDataBaseHandler instance = BHMDataBaseHandler._privatecons();

  Future<Database> get bhmdatabase async {
    if (_bhmdatabase != null) {
      return _bhmdatabase!;
    } else {
      _bhmdatabase = await initDatabase();
      return _bhmdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bhm.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bhmtable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> bhminsertmodel(Model model) async {
    Database db = await instance.bhmdatabase;
    db.insert('bhmtable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bhmdisplaymodel() async {
    Database db = await instance.bhmdatabase;
    List<Map<String, dynamic>> maps = await db.query('bhmtable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bhmdeletemodel(int id) async {
    Database db = await instance.bhmdatabase;
    db.delete('bhmtable', where: 'id= ?', whereArgs: [id]);
  }
}
