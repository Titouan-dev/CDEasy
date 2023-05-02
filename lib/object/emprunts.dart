
class Emprunt {
    int id;
    int emprunteurId;
    int livreId;
    String startDate;
    String supposedEndDate;
    String endDate;

    Emprunt(this.id, this.emprunteurId, this.livreId, this.startDate, this.supposedEndDate, this.endDate);

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
      map["endDate"]
    );
}