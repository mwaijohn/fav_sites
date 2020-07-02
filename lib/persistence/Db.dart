import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static Database connection;

  static init() async{
    connection = await dataBaseConnection();
  }
  static dataBaseConnection() async {
    // Open the database and store the reference.
    final Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'links_database.db'),
      // When the database is first created, create a table to store dogs.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE fav_sites(id INTEGER PRIMARY KEY, name TEXT, link TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }

}