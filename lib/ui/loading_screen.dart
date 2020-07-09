import 'package:fav_sites/persistence/Db.dart';
import 'package:fav_sites/persistence/connection.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LoadingScreen extends StatefulWidget {

  //get d connection
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  getConnection() async{
    Db.init();
    Future.delayed(Duration(seconds: 3),(){
      print(Db.connection);
      Navigator.pushReplacementNamed(context, "/sites");
    });
  }

  @override
  void initState(){
    super.initState();
    getConnection();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
          child: Center(
            child: Text("Loading ...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
              color: Colors.white,
              letterSpacing: 1.3
            ),),
          )
      ),
    );
  }
}

/*
*
* ListView.builder(
            itemBuilder: (context,position){
              return SiteCard(data: storedSites[position],delete: (){
                print(storedSites[position].id);
//                Data data = Data();
//                data.deleteSite(db,storedSites[position].id);
                setState(() {
                  storedSites.remove(position,);
                });
             _showDialog(context,storedSites[position].id);
              },);
            },
            itemCount: storedSites.length,
          )*/