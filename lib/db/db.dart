import 'dart:io';

import 'package:notes_app/Network/remote/dio_helper.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    }
    //define the path to the database
    // Directory directory = await getApplicationDocumentsDirectory();
    String path = join(await getDatabasesPath(), 'n.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) {
        //create all tables
        db.execute(
            "CREATE TABLE note(id INTEGER PRIMARY KEY AUTOINCREMENT, Text TEXT,date TEXT)");
      },
    );
    return _db;
  }

  // insert({
  //   required noteModel note,
  // }) async {
  //   await _db?.transaction((txn) {
  //     return txn.rawInsert('INSERT INTO note(Text) VALUES("${note.Text}")');
  //   }).then((value) {
  //     allCourses();
  //   });
  Future<int> insert({noteModel? note}) async {
    Database? db = await _instance.database;
    //db.rawInsert('insert into courses value')
    return db!.insert('note', note!.toMap());
  }

  // Database? db = await createDatabase();
  // //db.rawInsert('insert into courses')
  // return db!.insert('note', course.toMap());

  Future<List> allnotes() async {
    Database? db = await _instance.database;

    // return db!.rawQuery("select * from note");
    return await db!.query('note');
  }
  //   final List<Map<String, dynamic>> maps =
  //       await db!.rawQuery("select * from note");
  //
  //   // return List.generate(
  //   //   maps.length,
  //   //   (index) {
  //   //     return noteModel(
  //   //       id: maps[index]["id"],
  //   //       Text: maps[index]["Text"],
  //   //     );
  //   //   },
  //   // );
  // }
  // return db!.query('note');

  Future<int> delete(int id) async {
    Database? db = await _instance.database;
    return db!.delete('note', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteaLLnote(int id) async {
    Database? db = await _instance.database;
    return db!.delete(
      'note',
    );
  }

  Future<int> update(noteModel model) async {
    Database? db = await _instance.database;
    return await db!
        .update('note', model.toMap(), where: 'id = ?', whereArgs: [model.id]);
  }
}
