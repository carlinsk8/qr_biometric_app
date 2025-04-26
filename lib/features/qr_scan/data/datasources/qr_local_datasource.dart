import '../../domain/entities/qr_code.dart';
import '../models/qr_code_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class QrLocalDatasource {
  static const String _dbName = 'qr_codes.db';
  static const String _tableName = 'qr_codes';

  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, _dbName),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $_tableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT,
            timestamp TEXT
          )
          '''
        );
      },
      version: 1,
    );
  }

  Future<void> saveQrCode(String qrCode) async {
    final db = await database;
    await db.insert(
      _tableName,
      QrCodeModel(code: qrCode, timestamp: DateTime.now().toIso8601String()).toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<QrCode>> getAllQrCodes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return QrCodeModel.fromMap(maps[i]);
    });
  }
}
