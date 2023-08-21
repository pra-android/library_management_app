import 'dart:async';
import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BBSDataBaseHandler {
  static Database? _bbsdatabase;

  //Singleton  Concept
  BBSDataBaseHandler._privatecons();
  static final BBSDataBaseHandler instance = BBSDataBaseHandler._privatecons();

  Future<Database> get bbsdatabase async {
    if (_bbsdatabase != null) {
      return _bbsdatabase!;
    } else {
      _bbsdatabase = await initDatabase();
      return _bbsdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bbs.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bbstable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> bbsinsertmodel(Model model) async {
    Database db = await instance.bbsdatabase;
    db.insert('bbstable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bbsdisplaymodel() async {
    Database db = await instance.bbsdatabase;
    List<Map<String, dynamic>> maps = await db.query('bbstable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bbsdeletemodel(int id) async {
    Database db = await instance.bbsdatabase;
    db.delete('bbstable', where: 'id= ?', whereArgs: [id]);
  }
}
