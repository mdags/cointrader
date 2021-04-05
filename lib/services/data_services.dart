import 'package:cointrader/models/favorites_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String favTable = 'favorites';
final String favId = 'id';
final String favMarketIdentifier = 'marketIdentifier';
final String favCoinId = 'coinId';
final String favCoinName = 'coinName';
final String favTarget = 'target';

class DataBaseServices {
  DataBaseServices._privateConstructor();
  static final DataBaseServices instance =
      DataBaseServices._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "coinmarket.db";

    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        create table $favTable (
          $favId integer primary key autoincrement,
          $favMarketIdentifier text not null,
          $favCoinId text not null,
          $favCoinName text not null,
          $favTarget text not null
        )
      ''');
    });
    return database;
  }

  Future<List<FavoritesModel>> getFavorites() async {
    var db = await this.database;
    var result = await db.query(favTable);
    List<FavoritesModel> list = result.isNotEmpty
        ? result.map((c) => FavoritesModel.fromMap(c)).toList()
        : [];
    return list;
  }

  Future<int> insertFavorite(FavoritesModel model) async {
    var db = await this.database;
    var result = await db.insert(favTable, model.toMap());
    return result;
  }

  Future<int> deleteFavorite(int id) async {
    var db = await this.database;
    var result = await db.delete(favTable, where: '$id = ?', whereArgs: [id]);
    return result;
  }
}
