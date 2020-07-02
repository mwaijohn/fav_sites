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
                Data data = Data();
                data.deleteSite(db,storedSites[position].id);
                setState(() {
                  storedSites.remove(position);
                });
              },);
            },
            itemCount: storedSites.length,
          )
        )
    );
  }
}
