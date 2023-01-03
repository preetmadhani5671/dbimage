import 'dart:io';
import 'dart:typed_data';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> checkDb() async {
    if (db != null) {
      return db!;
    } else {
      return await createDb();
    }
  }

  Future<Database> createDb() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, "pm.db");

    return openDatabase(path, version: 1, onCreate: (db, version) {
      String query = "CREATE TABLE std(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,mobile TEXT,photo BLOG)";
      db.execute(query);
    });
  }

  void insertData(String NAME, String MOBILE, Uint8List PHOTO) async {
    db = await checkDb();
    db!.insert("std", {"name": NAME, "mobile": MOBILE, "photo": PHOTO});
  }

  Future<List<Map>> readData() async {
    db = await checkDb();
    return db!.rawQuery("SELECT * FROM std", null);
  }


  void delete(String id)
  async{
    db = await checkDb();
    db!.delete("std",where: "id = ?",whereArgs: [id]);
  }


  void update(String n1,String m1,Uint8List iuni,String id)async{

    db = await checkDb();
    db!.update("std", {"name":n1,"mobile":m1,"photo":iuni},where: "id =?",whereArgs:[id] );
  }
}
