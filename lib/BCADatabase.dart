import 'dart:io';
import 'package:library_management_app/Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BCADataBaseHandler {
  static Database? _bcadatabase;

  //Singleton  Concept
  BCADataBaseHandler._privatecons();
  static final BCADataBaseHandler instance = BCADataBaseHandler._privatecons();

  Future<Database> get bcadatabase async {
    if (_bcadatabase != null) {
      return _bcadatabase!;
    } else {
      _bcadatabase = await initDatabase();
      return _bcadatabase!;
    }
  }

  initDatabase() async {
    Directory directorypath =
        await getApplicationDocumentsDirectory(); //It provides the folder where our app can easily kept the files or data
    String path = join(directorypath.path, 'bca.db');
    return openDatabase(path, onCreate: _oncreate, version: 1);
  }

  //Creatng the table
  Future<void> _oncreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE bcatable (id INTEGER PRIMARY KEY AUTOINCREMENT,studentname TEXT NOT NULL,semester INTEGER,Bookid TEXT NOT NULL)");
  }

  //Inserting the datas
  Future<Model?> bcainsertmodel(Model model) async {
    Database db = await instance.bcadatabase;
    db.insert('bcatable', model.tomap());
    return model;
  }

  //Displaying all Datas

  Future<List<Model>> bcadisplaymodel() async {
    Database db = await instance.bcadatabase;
    List<Map<String, dynamic>> maps = await db.query('bcatable');
    return List.generate(maps.length, (index) => Model.tojson(maps[index]));
  }

//Delete datas
  Future<int?> bcadeletemodel(int id) async {
    Database db = await instance.bcadatabase;
    db.delete('bcatable', where: 'id= ?', whereArgs: [id]);
  }
}
