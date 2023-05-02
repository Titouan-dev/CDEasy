import 'package:bts_emprunt/object/emprunteur.dart';
import 'package:flutter/cupertino.dart';
import 'object/emprunts.dart';
import 'object/livre.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
class dataBase {
  dataBase._();

  static final dataBase instance = dataBase._();
  static Database? _database;

  Future<Database> get database async =>
      _database ??= await initDB();

  initDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    return await databaseFactory.openDatabase(
      "C:/Users/Dev/StudioProjects/BTS_emprunt/cdi_database.db",
     // onCreate: (db,version) {
     //   return db.execute(
     //     """
     //
     //       CREATE TABLE emprunts(id INT PRIMARY KEY, emprunteurId INT, livreId INT, startDate TEXT, supposedEndDate TEXT, endDate TEXT)
     //     """
     //     );
     //   },
    );
  }

  void insertEmprunteur(Emprunteur emprunteur) async {
    final Database db = await database;

    await db.insert(
      'emprunteur',
      emprunteur.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertLivre(Livre livre) async {
    final Database db = await database;

    await db.insert(
      'livre',
      livre.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void insertEmprunt(Emprunt emprunts) async {
    final Database db = await database;

    await db.insert(
      'emprunts',
      emprunts.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void deleteEmprunteur(Emprunteur emprunteur) async {
    final Database db = await database;

    await db.delete("emprunteur", where: "id = ?", whereArgs: [emprunteur.id]);
  }

  void deleteEmprunts(Emprunt emprunts) async {
    final Database db = await database;

    await db.delete("emprunts", where: "id = ?", whereArgs: [emprunts.id]);
  }

  void deleteLivre(Livre livre) async {
    final Database db = await database;

    await db.delete("livre", where: "id = ?", whereArgs: [livre.id]);
  }

  void updateEmprunteur(Emprunteur emprunteur) async {
    final Database db = await database;

    await db.update(
      "emprunteur",
      emprunteur.toMap(),
      where: "id = ?", whereArgs: [emprunteur.id]
    );
  }

  void updateEmprunts(Emprunt emprunts) async {
    final Database db = await database;

    await db.update(
        "emprunts",
        emprunts.toMap(),
        where: "id = ?", whereArgs: [emprunts.id]
    );
  }

  void updateLivre(Livre livre) async {
    final Database db = await database;

    await db.update(
        "livre",
        livre.toMap(),
        where: "id = ?", whereArgs: [livre.id]
    );
  }

  Future<List<Livre>> livre() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("livre");
    List<Livre> livres = List.generate(maps.length, (i) => Livre.fromMap(maps[i]));
    return livres;
  }

  Future<int> livreLastIndex() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("livre");
    List<Livre> livres = List.generate(maps.length, (i) => Livre.fromMap(maps[i]));
    int m = 0;
    for (var i = 0; i<livres.length; i++) {
      if (livres[i].id > m) {
        m = livres[i].id;
      }
    }
    return m;
  }
}