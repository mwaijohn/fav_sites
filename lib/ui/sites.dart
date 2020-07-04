import 'package:fav_sites/persistence/DataModel.dart';
import 'package:fav_sites/persistence/Db.dart';
import 'package:fav_sites/ui/site_card.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class Sites extends StatefulWidget {
  @override
  _SitesState createState() => _SitesState();
}

class _SitesState extends State<Sites> {
  Map sites = {};
  List<Data> data;

  Database db;

  void _showDialog(context,id){
    showDialog(
        context: context,
      builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: Colors.black,
            contentTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.normal
            ),
            titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),
            title: Text("Delete item"),
            content: Text("Are you sure to delete this item?"),
            actions: <Widget>[
              GestureDetector(
                onTap: (){
                  Data data = Data();
                  data.deleteSite(db,id);
                  Navigator.of(context,rootNavigator: true).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Delete",
                  style: TextStyle(
                    letterSpacing: 1.2,
                    color: Colors.red,
                    fontSize: 16.0
                  ),),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context,rootNavigator: true).pop();
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                    child: Text("cancel",
                      style: TextStyle(
                          letterSpacing: 1.2,
                          color: Colors.red,
                          fontSize: 16.0
                      ),
                    )),
              )
            ],
          );
      }
    );
  }

  @override
  void initState(){
    super.initState();
    Db.init();
    db = Db.connection;
    print(db);
  }

  @override
  Widget build(BuildContext context) {

    sites = ModalRoute.of(context).settings.arguments;

    var storedSites = sites['sites'];
    //print(sites['sites']);
    //print(storedSites[0].id);
    //print(storedSites.runtimeType);

    return Scaffold(
      backgroundColor: Colors.amberAccent[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text("Favourite sites"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 0),
          child: ListView.builder(
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
          )
        )
    );
  }
}
