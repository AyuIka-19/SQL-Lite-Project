import 'package:flutter/material.dart';
// change `flutter_database` to whatever your project name is
import 'package:flutter_database/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  // homepage layout
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQFlite'),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text('Insert', style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: () {
                _insert();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Theme(
                      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.purple[800]),
                      child: AlertDialog(
                        title: Text("Notifikasi!",
                        style: TextStyle(color: Colors.white),),
                        content: Text("Input Data Berhasil",
                        style: TextStyle(color: Colors.white),),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK",
                            style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              Navigator.pop(context);
                            },),],),
                          );});},
            ),
            RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text('Query', style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: ()  {_query();},
            ),
            RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text('Update', style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: () {
                _update();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Theme(
                      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.purple[800]),
                      child: AlertDialog(
                        title: Text("Notifikasi!",
                        style: TextStyle(color: Colors.white),),
                        content: Text("Update Data Berhasil",
                        style: TextStyle(color: Colors.white),),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK",
                            style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              Navigator.pop(context);
                            },),],),
                          );});},
            ),
            RaisedButton(
              padding: EdgeInsets.all(10),
              color: Colors.black,
              child: Text('Delete', style: TextStyle(fontSize: 20, color: Colors.white),),
              onPressed: () {
                _delete();
                showDialog(
                  context: context,
                  builder: (context) {
                    return Theme(
                      data: Theme.of(context).copyWith(dialogBackgroundColor: Colors.purple[800]),
                      child: AlertDialog(
                        title: Text("Notifikasi!",
                        style: TextStyle(color: Colors.white),),
                        content: Text("Data Berhasil Dihapus",
                        style: TextStyle(color: Colors.white),),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("OK",
                            style: TextStyle(color: Colors.white),),
                            onPressed: (){
                              Navigator.pop(context);
                            },),],),
                          );});},
            ),
          ],
        ),
      ),
      
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60,
          color: Colors.blue[900],
          alignment: Alignment.center,
          child: Text(
            'Pemrograman Mobile',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white),
          ),
        ),
      ),
    );
  }
  
  // Button onPressed methods
  
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Ika',
      DatabaseHelper.columnAge  : 19
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Dewa Ayu Putu Ika Kasturi Dewi',
      DatabaseHelper.columnAge  : 19
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
}