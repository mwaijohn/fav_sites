import 'package:fav_sites/persistence/DataModel.dart';
import 'package:flutter/material.dart';

class SiteCard extends StatelessWidget {

  final Data data;
  final Function delete;
  SiteCard({this.data,this.delete});

  Future<String> getText() async{
    var myString = await "kjkjk";
    return myString;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GestureDetector(
          onTap: () async{
            print(this.data.id);
           // print(await getText());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.name,
                        style: TextStyle(
                            letterSpacing: 1.3,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        data.link,
                        style: TextStyle(
                            letterSpacing: 1.3,
                            fontSize: 20.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: delete,
                    child: Text(
                      "delete",
                      style: TextStyle(
                          letterSpacing: 1.3,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal,
                          color: Colors.red
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
