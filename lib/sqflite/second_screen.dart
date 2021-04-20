import 'package:flutter/material.dart';
import 'dart:async';
import 'package:form/sqflite/note_model_class.dart';
import 'package:form/sqflite/database_helper.dart';
import 'package:intl/intl.dart';

/// In this we get the input fields from user and saved local database

class SecondScreen extends StatefulWidget {

  final String screenTitle;
  final Note note;
  SecondScreen(this.note, this.screenTitle);

  @override
  _SecondScreenState createState() => _SecondScreenState(this.note, this.screenTitle);
}

class _SecondScreenState extends State<SecondScreen> {

  String screenTitle;
  Note note;
  _SecondScreenState(this.note, this.screenTitle);

  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    titleController.text = note.title;
    descriptionController.text =note.description;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context,true);
            },
          ),
          centerTitle: true,
          title: Text(screenTitle),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    // onChanged: (value){
                    //   note.title = titleController.text;
                    // },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  TextField(
                    controller: descriptionController,
                    // onChanged: (value){
                    //   note.description = descriptionController.text;
                    // },
                    decoration: InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(onPressed: (){
                        setState(() {
                          save();
                        });
                      },
                        child: Text('Submit'),
                        ),
                      RaisedButton(onPressed: (){
                        setState(() {
                          delete();
                        });
                      },
                        child: Text('Delete'),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() {
    Navigator.pop(context,true);
    return null;
  }


  void save() async {

    Navigator.pop(context,true);
    note.date = DateFormat.yMMMd().format(DateTime.now());
    note.title = titleController.text;
    note.description = descriptionController.text;
    int result;
    if (note.id != null) {  //  Update operation
      result = await databaseHelper.updateNote(note);
    } else { // Insert Operation
      result = await databaseHelper.insertNote(note);
    }
    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Note Saved Successfully');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem Saving Note');
    }

  }

  void delete() async {

    Navigator.pop(context,true);
    if (note.id == null) {
      _showAlertDialog('Status', 'No Note was deleted');
      return;
    }
    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    } else {
      _showAlertDialog('Status', 'Error Occurred while Deleting Note');
    }
  }


  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}
