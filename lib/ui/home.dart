import 'dart:math';

import 'package:fav_sites/persistence/Db.dart';
import 'package:flutter/material.dart';
import '../persistence/connection.dart';
import '../persistence/DataModel.dart';
import 'package:sqflite/sqflite.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final nameController = TextEditingController();
  final linkController = TextEditingController();
  //DatabaseConnection dbConnection = DatabaseConnection();
  Database dbConnection,db;
  var sitesData;

  //generate random number
  getRandomNo(){
    var random = Random();
    return random.nextInt(3000);
  }

  getDatabaseConnection() async{
    DatabaseConnection db = DatabaseConnection();
    dbConnection =  await db.dataBaseConnection();
    return dbConnection;
  }

  //save link
  saveData() async{
    Data data = Data(id: getRandomNo(),name: nameController.text,link: linkController.text);
    data.insertData(data, dbConnection);
  }

  //get list of data
  getData() async{
    var data =  Data();
    return await data.sites(dbConnection);
  }

  //show snackbar
  void _showToast(BuildContext context){
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
          content: Text("data"),
        action: SnackBarAction(label: "Ok", onPressed: scaffold.hideCurrentSnackBar),
      )
    );
  }


  @override
  void initState() {
    super.initState();
    getDatabaseConnection();

    Db.init();
    db = Db.connection;
    //print(db);
  }

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      backgroundColor: Colors.amberAccent[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Enter site Name"),
        centerTitle: false,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Site Name'),
              controller: nameController,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Enter site name'),
              controller: linkController,
            ),
            RaisedButton(
              child: Text("Save"),
              onPressed: () async {
                saveData();
                key.currentState.showSnackBar(
                    SnackBar(
                      content: Text("site added"),
                      action: SnackBarAction(label: "Ok",
                          onPressed: (){
                        Navigator.pop(context);
                          }
                      ),
                    )
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //_showToast(context);
          saveData();
          key.currentState.showSnackBar(
              SnackBar(
                content: Text("site added"),
//                action: SnackBarAction(label: "Ok", onPressed: scaffold.hideCurrentSnackBar),
              )
          );
        },
          child: Icon(Icons.add_circle),
      ),
    );
  }
}
