import 'package:sqflite/sqflite.dart';

class Data {
  final int id;
  final String name;
  final String link;

  Data({this.id, this.name, this.link});

  // Convert a Data nto a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'link': link,
    };
  }

  // Define a function that inserts dogs into the database
  Future<void> insertData(Data data, Database db) async {
    // Get a reference to the database.
    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'fav_sites',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the dogs table.
  Future<List<Data>> sites(Database db) async {
    // Get a reference to the database.

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('fav_sites');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Data(
        id: maps[i]['id'],
        name: maps[i]['name'],
        link: maps[i]['link'],
      );
    });
  }

  Future<void> updateSites(Database db, Data data) async {
    // Get a reference to the database.

    // Update the given Site.
    await db.update(
      'fav_sites',
      data.toMap(),
      // Ensure that the Data has a matching id.
      where: "id = ?",
      // Pass the Data id as a whereArg to prevent SQL injection.
      whereArgs: [data.id],
    );
  }

  Future<void> deleteSite(Database db,int id) async {
    // Get a reference to the database.


    // Remove the Dog from the Database.
    await db.delete(
      'fav_sites',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
 }

}
