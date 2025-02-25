import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  //Making class a singleton to make sure that it does`nt have multiple objects

  DbHelper._(); //privatizing constructor using a _ sign.it helps in making sure that object creation is closed outside class

  static final DbHelper getInstance = DbHelper._();

  //table note
  static final String TABLE_NAME = "NOTE";
  static final String COLUMN_S_NO = "s_no";
  static final String COLUMN_TITLE = "title";
  static final String COLUMN_DESCRIPTION = "description";

  Database? myDB;

  //open database (open database if already created but if not create new one)
  Future<Database> getDB() async {
    myDB = myDB ?? await openDB();
    return myDB!;

    //or
    // if (myDB != null) {
    //   return myDB!;
    // } else {
    //   myDB = await openDB();
    //   return myDB!;
    // }
  }

  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dirPath = join(appDir.path, 'note.db');

    return await openDatabase(dirPath, onCreate: (db, version) {
      //create all your tables here
      db.execute(
          "create table $TABLE_NAME ($COLUMN_S_NO integer primary key autoincrement, $COLUMN_TITLE text, $COLUMN_DESCRIPTION text)");
    }, version: 1);
  }

  //Insertion
  Future<bool> addNote(
      {required String myTitle, required String myDesc}) async {
    var db = await getDB();

    int rowsEffected = await db.insert(
        TABLE_NAME, {COLUMN_TITLE: myTitle, COLUMN_DESCRIPTION: myDesc});

    return rowsEffected > 0;
  }

  //Reading all data
  Future<List<Map<String, dynamic>>> getAllNotes() async {
    var db = await getDB();

    List<Map<String, dynamic>> myData = await db.query(TABLE_NAME);

    return myData;
  }

  Future<int> deleteNotes(int sNo) async {
    var db = await getDB();
    return await db
        .delete(TABLE_NAME, where: '$COLUMN_S_NO = ?', whereArgs: [sNo]);
  }

  // Updating an existing note
  Future<bool> updateNote(
      {required int sNo,
      required String myTitle,
      required String myDesc}) async {
    var db = await getDB();

    int rowsEffected = await db.update(
      TABLE_NAME,
      {COLUMN_TITLE: myTitle, COLUMN_DESCRIPTION: myDesc},
      where: '$COLUMN_S_NO = ?',
      whereArgs: [sNo],
    );

    return rowsEffected > 0;
  }

  Future<void> resetAutoIncrement() async {
  final db = await getDB();
  await db.execute("DELETE FROM sqlite_sequence WHERE name = '$TABLE_NAME'");
}

}
