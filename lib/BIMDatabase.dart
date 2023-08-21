import 'dart:async';
import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BIMDataBaseHandler {
  static Database? _bimdatabase;

  //Singleton  Concept
  BIMDataBaseHandler._privatecons();
  static final BIMDataBaseHandler instance = BIMDataBaseHandler._privatecons();

  Future<Database> get bimdatabase async {
    if (_bimdatabase != null) {
      return _bimdatabase!;
    } else {
      _bimdatabase = await initDatabase();
      return _bimdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bim.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bimtable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> biminsertmodel(Model model) async {
    Database db = await instance.bimdatabase;
    db.insert('bimtable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bimdisplaymodel() async {
    Database db = await instance.bimdatabase;
    List<Map<String, dynamic>> maps = await db.query('bimtable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bimdeletemodel(int id) async {
    Database db = await instance.bimdatabase;
    db.delete('bimtable', where: 'id= ?', whereArgs: [id]);
  }
}
