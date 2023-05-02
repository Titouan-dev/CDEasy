class Livre {
  String titre;
  int id;
  String etat;
  String status;

  Livre(this.titre, this.id, this.etat, this.status);

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'id': id,
      'etat': etat,
      'status': status,
    };
  }

  factory Livre.fromMap(Map<String, dynamic> map) => Livre(
    map["titre"],
    map["id"],
    map["etat"],
    map["status"],
  );

}