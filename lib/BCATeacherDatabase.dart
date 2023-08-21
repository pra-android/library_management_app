import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BBSTeacherDataBaseHandler {
  static Database? _bbsteacherdatabase;

  //Singleton  Concept
  BBSTeacherDataBaseHandler._privatecons();
  static final BBSTeacherDataBaseHandler instance =
      BBSTeacherDataBaseHandler._privatecons();

  Future<Database> get bbsteacherdatabase async {
    if (_bbsteacherdatabase != null) {
      return _bbsteacherdatabase!;
    } else {
      _bbsteacherdatabase = await initDatabase();
      return _bbsteacherdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bbsteacher.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bbsteachertable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> bbsteacherinsertmodel(Model model) async {
    Database db = await instance.bbsteacherdatabase;
    db.insert('bbsteachertable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bbsteacherdisplaymodel() async {
    Database db = await instance.bbsteacherdatabase;
    List<Map<String, dynamic>> maps = await db.query('bbsteachertable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bbsteacherdeletemodel(int id) async {
    Database db = await instance.bbsteacherdatabase;
    db.delete('bbsteachertable', where: 'id= ?', whereArgs: [id]);
  }
}
