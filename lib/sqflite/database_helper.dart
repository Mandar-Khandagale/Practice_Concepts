import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:form/sqflite/note_model_class.dart';

///Database file to create database locally and performed CRUD operation.

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;   //Singleton DatabaseHelper
  static Database _database;               //Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';

  DatabaseHelper._createInstance();        //named constructor to create instance of DatabaseHelper

  factory DatabaseHelper(){

    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();  //Executed only once. Singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase = await openDatabase(path,version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colDate TEXT )');
  }

  //Fetch Operation:
  Future<List<Map<String,dynamic>>>getNoteMapList() async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $noteTable ');
    return result;
  }
  //Insert Operation:
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //Update Operation:
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation:
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  //Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //Get Map List and Convert it into Note List
  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}