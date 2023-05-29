import 'package:bts_emprunt/dataBase.dart';

class Emprunt {
    late int id;
    late int emprunteurId;
    late int livreId;
    late String startDate;
    late String supposedEndDate;
    late String endDate;
    late String emprunteur;
    late String livre;

    Emprunt(int id, int emprunteurId, int livreId, String startDate, String supposedEndDate, String endDate, String emprunteur, String livre) {
      this.id = id;
      this.emprunteurId = emprunteurId;
      this.livreId = livreId;
      this.startDate = startDate;
      this.supposedEndDate = supposedEndDate;
      this.endDate = endDate;
      this.emprunteur = emprunteur;
      this.livre = livre;
    }

    Map<String, dynamic> toMap() {
      return {
        'id': id,
        'emprunteurId': emprunteurId,
        'livreId': livreId,
        'startDate': startDate,
        'supposedEndDate': supposedEndDate,
        'endDate': endDate,
      };
    }

    factory Emprunt.fromMap(Map<String, dynamic> map) => Emprunt(
      map["id"],
      map["emprunteurId"],
      map["livreId"],
      map["startDate"],
      map["supposedEndDate"],
      map["endDate"],
      map["emprunteur"],
      map["livre"]
    );

    double getTime() {
      DateTime from = DateTime.parse(this.startDate);
      DateTime to = DateTime.parse(this.supposedEndDate);
      DateTime actual = DateTime.now();
      int totalDay = daysBetween(from, to);
      int doneDay = daysBetween(from, actual);
      return doneDay/totalDay;
    }

    int daysBetween(DateTime from, DateTime to) {
      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    LoadData() async {
      this.emprunteur = await dataBase.instance.getEmprunteur(this.emprunteurId);
      this.livre = await dataBase.instance.getLivre(this.livreId);
    }
}