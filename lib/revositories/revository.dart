import 'package:flutter_form_games/revositories/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository{
  DatabaseConnection _databaseConnection;

  Repository(){
    _databaseConnection = DatabaseConnection();
  }

  static Database _database;

  //mengecek jika database keluar atau tidak
  Future<Database> get database async{
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }
  //memasukan data ke tabel
  insertData(table, data) async{
    var connection = await database;
    return await connection.insert(table, data);
  }
  //baca data dari tabel
  readData(table) async{
    var connection = await database;
    return await connection.query(table);
  }

  //baca data dari tabel menggunakan id
  readDataById(table, itemId) async{
    var connection = await database;
    return await connection.query(table,where: 'id=?', whereArgs: [itemId]);
  }

  //edite data dari tabel
  updateData(table, data) async {
    var connection = await database;
    return await connection
        .update(table, data, where: 'id=?',whereArgs: [data['id']]);
  }

  //hapus data dari tabel
  deleteData(table, itemId) async{
    var connection = await database;
    return await connection.rawDelete("DELETE FROM $table WHERE id = $itemId");
  }

  //membaca data dari tabel menggunakan nama
  readDataByColumnName(table, columnName, columnValue) async {
  var connection = await database;
  return await connection.query(table, where: '$columnName=?', whereArgs: [columnValue]);
  }
}