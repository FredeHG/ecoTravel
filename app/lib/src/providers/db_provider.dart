import 'dart:io';

import 'package:app/src/models/boleto_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final table = 'Boletos';
  static Database _dataBase;
  static final DbProvider db = DbProvider._();

  DbProvider._();
  Future<Database> get dataBase async => _dataBase ?? await initDb();

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'ScansDb.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $table ('
          ' id INTEGER PRIMARY KEY,'
          'valor TEXT'
          ')',
        );
      },
    );
  }

  nuevoScanRow(ScanModel scan) async {
    final db = await dataBase;
    final res = await db.rawInsert(
      "INSERT Into Scans (id, valor) "
      "VALUES (${scan.id}, '${scan.valor}')",
    );
    return res;
  }

  nuevoScan(ScanModel nuevoScan) async {
    final db = await dataBase;
    final res = await db.insert(table, nuevoScan.toJson());
    return res;
  }

  Future<ScanModel> getScanId(int id) async {
    final db = await dataBase;
    final res = await db.query(table, where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosScans() async {
    final db = await dataBase;
    final res = await db.query(table);

    List<ScanModel> list =
        res.isNotEmpty ? res.map((c) => ScanModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateScan(ScanModel scan) async {
    final db = await dataBase;
    final res = await db.update(
      table,
      scan.toJson(),
      where: 'id = ?',
      whereArgs: [nuevoScan(scan).id],
    );
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await dataBase;
    final res = await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return res;
  }

  Future<int> deleteAll() async {
    final db = await dataBase;
    final res = await db.delete(table);
    return res;
  }
}
