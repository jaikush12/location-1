import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

import 'DataModel.dart';

class LocationDbHelper {
  static const String dbName = 'locations.db';
  static const String table = 'location_points';

  static Future<Database> getDatabase() async {
    final databasePath = await getDatabasesPath();
    return await openDatabase(
      path.join(databasePath, dbName),
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp INTEGER NOT NULL,
            latitude REAL NOT NULL,
            longitude REAL NOT NULL,
            additionalData TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<int> insertLocation(LocationPoint locationPoint) async {
    final db = await getDatabase();
    return await db.insert(table, locationPoint.toMap());
  }

  static Future<List<LocationPoint>> getAllLocations() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) => LocationPoint.fromMap(maps[i]));
  }
  static Future<int?> deleteLocation(int id) async {
    final db = await getDatabase();
    final deletedCount = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return deletedCount > 0 ? id : null; // Return ID if deleted, null otherwise
  }
}
