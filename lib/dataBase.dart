
import 'package:bts_emprunt/object/emprunteur.dart';
import 'package:bts_emprunt/page/actifs/myForm.dart';
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
      "C:/Users/Etudiant/StudioProjects/BTS_emprunt/cdi_database.db",
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

  void insertLivre(LivreData livre) async {
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
      'emprunt',
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

  void deleteLivre(LivreData livre) async {
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
        "emprunt",
        emprunts.toMap(),
        where: "id = ?", whereArgs: [emprunts.id]
    );
  }

  void updateLivre(LivreData livre) async {
    final Database db = await database;

    await db.update(
        "livre",
        livre.toMap(),
        where: "id = ?", whereArgs: [livre.id]
    );
  }

  Future<List<LivreData>> livre(String search) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("livre");
    List<LivreData> livres = List.generate(
        maps.length, (i) => LivreData.fromMap(maps[i]));
    if (search == null || search.replaceAll(" ", "") == "") {
      return livres;
    } else {
      List<LivreData> tmp = [];
      for (int i = 0; i < livres.length; i++) {
        if (livres[i].titre.contains(search) ||
            livres[i].status.contains(search) ||
            livres[i].etat.contains(search)) {
          tmp.add(livres[i]);
        }
      }
      return tmp;
    }
  }

  Future<List<LivreData>> availLivre() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("livre");
    List<LivreData> livres = List.generate(maps.length, (i) => LivreData.fromMap(maps[i]));
    List<LivreData> tmp = [];
    for(int i=0; i<livres.length; i++) {
      if (livres[i].status == "En Stock") {
        tmp.add(livres[i]);
      }
    }
    return tmp;
  }

  Future<int> livreLastIndex() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("livre");
    List<LivreData> livres = List.generate(
        maps.length, (i) => LivreData.fromMap(maps[i]));
    int m = 0;
    for (var i = 0; i < livres.length; i++) {
      if (livres[i].id > m) {
        m = livres[i].id;
      }
    }
    return m;
  }

  Future<List<Emprunteur>> emprunteur(String search) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("emprunteur");
    List<Emprunteur> emprunteurs = List.generate(
        maps.length, (i) => Emprunteur.fromMap(maps[i]));
    if (search.replaceAll(" ", "") == "") {
      return emprunteurs;
    } else {
      List<Emprunteur> tmp = [];
      for (int i = 0; i < emprunteurs.length; i++) {
        if (emprunteurs[i].prenom.contains(search) ||
            emprunteurs[i].nom.contains(search) ||
            emprunteurs[i].status.contains(search)) {
          tmp.add(emprunteurs[i]);
        }
      }
      return tmp;
    }
  }

  Future<int> emprunteurLastIndex() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("emprunteur");
    List<Emprunteur> emprunteurs = List.generate(
        maps.length, (index) => Emprunteur.fromMap(maps[index]));
    int m = 0;
    for (int i = 0; i < emprunteurs.length; i++) {
      if (emprunteurs[i].id > m) {
        m = emprunteurs[i].id;
      }
    }
    return m;
  }

  Future<List<Emprunt>> emprunt(String search) async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query("emprunt");
    List<Emprunt> emprunts = []; //List.generate(maps.length, (i) => Emprunt.fromMap(maps[i]));
    for (int i=0; i<maps.length; i++) {
      String emprunteure = await getEmprunteur(maps[i]["emprunteurId"]);
      String livre = await getLivre(maps[i]["livreId"]);
      emprunts.add(Emprunt(maps[i]["id"], maps[i]["emprunteurId"], maps[i]["livreId"], maps[i]["startDate"], maps[i]["supposedEndDate"], maps[i]["endDate"], emprunteure, livre));
    }
    List<Emprunt> tmp = [];
    for (int i=0; i<emprunts.length; i++) {
      if (emprunts[i].endDate == "") {
        tmp.add(emprunts[i]);
      }
    }
    emprunts = tmp;
    if (search.replaceAll(" ", "") == "") {
      return emprunts;
    } else {
      List<Emprunt> tmp = [];
      for (int i = 0; i < emprunts.length; i++) {
        String emprunt = await getEmprunteur(emprunts[i].emprunteurId);
        String livre = await getLivre(livres[i].id);
        if (emprunt.toLowerCase().contains(search.toLowerCase()) || livre.toLowerCase().contains(search.toLowerCase())) {
          tmp.add(emprunts[i]);
        }
      }
      return tmp;
    }
  }

  Future<int> empruntLastIndex() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("emprunt");
    List<Emprunt> emprunts = []; //List.generate(maps.length, (i) => Emprunt.fromMap(maps[i]));
    for (int i=0; i<maps.length; i++) {
      String emprunteure = await getEmprunteur(maps[i]["emprunteurId"]);
      String livre = await getLivre(maps[i]["livreId"]);
      emprunts.add(Emprunt(maps[i]["id"], maps[i]["emprunteurId"], maps[i]["livreId"], maps[i]["startDate"], maps[i]["supposedEndDate"], maps[i]["endDate"], emprunteure, livre));
    }
    int m = 0;
    for (int i = 0; i < emprunts.length; i++) {
      if (emprunts[i].id > m) {
        m = emprunts[i].id;
      }
    }
    return m;
  }

  Future<String> getEmprunteur(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("emprunteur");
    List<Emprunteur> emprunteurs  = List.generate(maps.length, (index) => Emprunteur.fromMap(maps[index]));
    for (int i=0; i<emprunteurs.length; i++) {
      if (emprunteurs[i].id == id) {
        return "${emprunteurs[i].prenom} ${emprunteurs[i].nom}";
      }
    }
    return "";
  }

  Future<String> getLivre(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query("livre");
    List<LivreData> livres = List.generate(maps.length, (index) => LivreData.fromMap(maps[index]));
    for (int i=0; i<livres.length; i++) {
      if (livres[i].id == id) {
        return livres[i].titre;
      }
    }
    return "";
  }
}