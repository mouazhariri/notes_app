// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:notes_app/Cubit/state.dart';
// import 'package:notes_app/model/note_model.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class cubit extends Cubit<noteState> {
//   cubit() : super(noteStateIntial());
//   noteModel? notes;
//   List<noteModel>? notess;
//   static cubit get(context) => BlocProvider.of(context);
//
//   Database? database;
//   List<Map> newTasks = [];
//   List<Map> doneTasks = [];
//   List<Map> archivedTasks = [];
//
//   void createDatabase() {
//     openDatabase(
//       'nn.db',
//       version: 1,
//       onCreate: (database, version) {
//         // id integer
//         // title String
//         // date String
//         // time String
//         // status String
//
//         print('database created');
//         database
//             .execute(
//                 'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
//             .then((value) {
//           print('table created');
//         }).catchError((error) {
//           print('Error When Creating Table ${error.toString()}');
//         });
//       },
//       onOpen: (database) {
//         getDataFromDatabase(database);
//         print('database opened');
//       },
//     ).then((value) {
//       database = value;
//       emit(AppCreateDatabaseState());
//     });
//   }
//
//   insertToDatabase({
//     @required String? title,
//     @required String? time,
//     @required String? date,
//   }) async {
//     await database!.transaction((txn) {
//       return txn
//           .rawInsert(
//         'INSERT INTO tasks(title, date, time, status) VALUES("$title", "$date", "$time", "new")',
//       )
//           .then((value) {
//         print('$value inserted successfully');
//         emit(AppInsertDatabaseState());
//
//         getDataFromDatabase(database);
//       }).catchError((error) {
//         print('Error When Inserting New Record ${error.toString()}');
//       });
//     });
//   }
//
//   void getDataFromDatabase(database) {
//     emit(AppGetDatabaseLoadingState());
//
//     database.rawQuery('SELECT * FROM tasks').then((value) {
//       value.forEach((element) {});
//
//       emit(AppGetDatabaseState());
//     });
//   }
//   //
//   // void updateData({
//   //   @required String status,
//   //   @required int? id,
//   // }) async
//   // {
//   //   database.rawUpdate(
//   //     'UPDATE tasks SET status = ? WHERE id = ?',
//   //     ['$status', id],
//   //   ).then((value)
//   //   {
//   //     getDataFromDatabase(database);
//   //     emit(AppUpdateDatabaseState());
//   //   });
//   // }
//
//   void deleteData({
//     @required int? id,
//   }) async {
//     database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
//       getDataFromDatabase(database);
//       emit(AppDeleteDatabaseState());
//     });
//   }
//
// // static Database? _database;
//   // //creating getter the database
//   // createDatabase() async {
//   //   if (_database != null) {
//   //     return _database;
//   //   }
//   //   _database = await initDB();
//   //   return _database;
//   // }
//   //
//   // initDB() async {
//   //   String path = join(await getDatabasesPath(), 'note.db');
//   //   _database = await openDatabase(
//   //     path,
//   //     version: 1,
//   //     onCreate: (Database db, int version) async {
//   //       await db.execute(
//   //           'create table notes(id integer primary key autoincrement, Text text,date Date)');
//   //     },
//   //   ).then((value) {
//   //     emit(AppCreateDatabaseState());
//   //   });
//   // }
//   //
//   // Future<int> addNewNote(noteModel note) async {
//   //   Database? db = await createDatabase();
//   //   // db.rawInsert('insert into notes value');
//   //   return db!.insert(
//   //     'notes', note.toMap(),
//   //     // conflictAlgorithm: ConflictAlgorithm.replace
//   //   );
//   // }
//   //
//   // Future<List> allnotes() async {
//   //   Database? db = await createDatabase();
//   //   // db.rawQuery('select * from notes');
//   //   return db!.query('notes');
//   // }
//   //
//   // delete(int id) async {
//   //   Database? db = await createDatabase();
//   //   return db!.delete('notes', where: 'id=?', whereArgs: [id]);
//   // }
// }
