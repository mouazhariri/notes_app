// import 'dart:async';
// import 'package:flutter/material.dart';
// // import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';
// import 'dart:io';
// // import 'package:sqflite/sqflite.dart';
//
// class dbhelper extends StatefulWidget {{
//
//   static String databaseName = 'dbfm.db';
//
//   static String _createfmtb =
//       "CREATE TABLE fm (id	INTEGER,family_id	INTEGER NOT NULL,father	text);";
//   static Database _db;
//   static Future<Database> getdb() async {
//     if (_db != null) {
//       return _db;
//     } else {
//       _db = await Opendb();
//       return _db;
//     }
//   }
//
//   static Future<Database> Opendb() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     String path = join(dir.path, databaseName);
//     var mintendb = await openDatabase(path, version: 1, onCreate: _FirstCreate);
//     return mintendb;
//   }
//
//   static Future<void> Restart() async {
//     Directory dir = await getApplicationDocumentsDirectory();
//     String path = join(dir.path, databaseName);
//     File f = new File(path);
//     _db = null;
//     if (f.existsSync()) {
//       await deleteDatabase(path);
//       _db = null;
//
//       print('database deleted ');
//     }
//   }
//
//   static Future<void> _FirstCreate(Database db, int version) async {
//     await db.execute(_createfmtb);
//   }
//
//   static Future<void> Closedb() async {
//     var db = await getdb();
//     db.close();
//     _db = null;
//   }
// }
