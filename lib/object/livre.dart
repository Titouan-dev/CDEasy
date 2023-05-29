class LivreData {
  String titre;
  int id;
  String etat;
  String status;

  LivreData(this.titre, this.id, this.etat, this.status);

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'id': id,
      'etat': etat,
      'status': status,
    };
  }

  factory LivreData.fromMap(Map<String, dynamic> map) => LivreData(
    map["titre"],
    map["id"],
    map["etat"],
    map["status"],
  );

}