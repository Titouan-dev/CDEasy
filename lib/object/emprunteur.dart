

class Emprunteur {
  String prenom;
  String nom;
  int id;
  String status;

  Emprunteur(this.prenom, this.nom, this.id, this.status);

  Map<String, dynamic> toMap() {
    return {
      'prenom': prenom,
      'nom': nom,
      'id': id,
      'status': status
    };
  }

  factory Emprunteur.fromMap(Map<String, dynamic> map) => Emprunteur(
      map["prenom"],
      map["nom"],
      map["id"],
      map["status"]
  );

}