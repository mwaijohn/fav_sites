import 'dart:math';

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
  Database dbConnection;
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


  @override
  void initState() {
    super.initState();
    getDatabaseConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text("Go to main"),
              onPressed: () async {
                sitesData = await getData();
                Navigator.pushNamed(context, "/sites",arguments: {
                  "sites": sitesData,
                });
                print(sitesData);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          saveData();
        },
          child: Icon(Icons.add_circle),
      ),
    );
  }
}
