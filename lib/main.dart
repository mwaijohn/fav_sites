import 'package:fav_sites/ui/view_site.dart';
import 'package:flutter/material.dart';
import 'ui/home.dart';
import 'ui/sites.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: Colors.blue,
    ),
    initialRoute: "/home",
    routes: {
      "/home": (context) => Home(),
      "/sites": (context) => Sites(),
      "/viewsite": (context) => ViewSite()
    },
  ));
}