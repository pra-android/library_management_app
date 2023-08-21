import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CSITTeacherDataBaseHandler {
  static Database? _csitteacherdatabase;

  //Singleton  Concept
  CSITTeacherDataBaseHandler._privatecons();
  static final CSITTeacherDataBaseHandler instance =
      CSITTeacherDataBaseHandler._privatecons();

  Future<Database> get csitteacherdatabase async {
    if (_csitteacherdatabase != null) {
      return _csitteacherdatabase!;
    } else {
      _csitteacherdatabase = await initDatabase();
      return _csitteacherdatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'csitteacher.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE csitteachertable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> csitteacherinsertmodel(Model model) async {
    Database db = await instance.csitteacherdatabase;
    db.insert('csitteachertable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> csitteacherdisplaymodel() async {
    Database db = await instance.csitteacherdatabase;
    List<Map<String, dynamic>> maps = await db.query('csitteachertable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> csitteacherdeletemodel(int id) async {
    Database db = await instance.csitteacherdatabase;
    db.delete('csitteachertable', where: 'id= ?', whereArgs: [id]);
  }
}
