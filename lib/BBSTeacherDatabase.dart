import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BCATeacherDataBaseHandler {
  static Database? _bcateacherdatabase;

  //Singleton  Concept
  BCATeacherDataBaseHandler._privatecons();
  static final BCATeacherDataBaseHandler instance =
      BCATeacherDataBaseHandler._privatecons();

  Future<Database> get bcateacherdatabase async {
    if (_bcateacherdatabase != null) {
      return _bcateacherdatabase!;
    } else {
      _bcateacherdatabase = await initDatabase();
      return _bcateacherdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bcateacher.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bcateachertable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> bcateacherinsertmodel(Model model) async {
    Database db = await instance.bcateacherdatabase;
    db.insert('bcateachertable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bcateacherdisplaymodel() async {
    Database db = await instance.bcateacherdatabase;
    List<Map<String, dynamic>> maps = await db.query('bcateachertable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bcateacherdeletemodel(int id) async {
    Database db = await instance.bcateacherdatabase;
    db.delete('bcateachertable', where: 'id= ?', whereArgs: [id]);
  }
}
