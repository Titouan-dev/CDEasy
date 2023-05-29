import 'package:bts_emprunt/dataBase.dart';
import 'package:bts_emprunt/object/emprunteur.dart';
import 'package:bts_emprunt/object/emprunts.dart';
import 'package:bts_emprunt/object/livre.dart';
import 'package:bts_emprunt/page/actifs/actif.dart';
import 'package:bts_emprunt/page/actifs/dataTable.dart';
import 'package:bts_emprunt/page/emprunteur/emprunteur.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

Emprunteur? selectedEmprunteur = null;
LivreData? selectedLivre = null;
late Future<List<Emprunteur>> taskList;
late Future<List<LivreData>> taskList2;
List<Emprunteur> emprunteurs = [];
List<LivreData> livres = [];
DateTime currentDate = DateTime.now();

LoadData() async {
  taskList = dataBase.instance.emprunteur("");
  taskList2 = dataBase.instance.availLivre();
  emprunteurs = await taskList;
  livres = await taskList2;
}

class myForm extends StatefulWidget {
  final actif act;
  const myForm(this.act);
  @override
  State<myForm> createState() => _myFormState();

}

class _myFormState extends State<myForm>  {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Container(
          width: 1500,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 25),
            child: Text("Nouvelle emprunt", style: TextStyle(fontSize: 16, color: Colors.blue),),
          ),
        )),
        Padding(padding:EdgeInsets.all(20), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Emprunteur:"),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                  child: Container(
                    width: 200,
                    child: dropDownEmprunteur(),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text("Livre:"),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                  child: Container(
                    width: 200,
                    child: dropDownLivre(),
                  ),
                )
              ],
            ),
            myDatePicker(),
            Padding(
                padding: EdgeInsets.fromLTRB(5, 40, 15, 0),
                child: ElevatedButton(
                    onPressed: () async {
                      dataBase.instance.insertEmprunt(Emprunt(await dataBase.instance.empruntLastIndex()+1, selectedEmprunteur!.id, selectedLivre!.id, DateTime.now().toIso8601String(),currentDate.toIso8601String(), "", "", ""));
                      dataBase.instance.updateLivre(LivreData(selectedLivre!.titre, selectedLivre!.id, selectedLivre!.etat, "Hors Stock"));
                      widget.act.refresh();
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 70)),
                    ),
                    child: Text("Ajouter"))),

          ],
        ))
      ],
    );
  }
}

class myDatePicker extends StatefulWidget {
  const myDatePicker({super.key});

  @override
  State<myDatePicker> createState() => _myDatePickerState();
}

class _myDatePickerState extends State<myDatePicker> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text("Date de retour:"),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
          child: OutlinedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(200, 50)),
            ),
            onPressed: () => _selectDate(context),
            child: Text(currentDate.toString().split(" ")[0]),
          ),
        ),
      ],
    );
  }
}

class dropDownEmprunteur extends StatefulWidget {
  const dropDownEmprunteur({super.key});

  @override
  State<dropDownEmprunteur> createState() => _dropDownEmprunteurState();
}

class _dropDownEmprunteurState extends State<dropDownEmprunteur> {
  var items;
  @override
  void initState() {
    super.initState();
    LoadData();
    items = emprunteurs.map((item) {
      return DropdownMenuItem(
        value: item,
        child: Text("${item.prenom} ${item.nom}"),
      );
    }).toList();
    selectedEmprunteur = Emprunteur("","", 0, "");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        child:
        Padding(
          padding: EdgeInsets.all(0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            onChanged: (Emprunteur? newValue) {
              setState(() {
                selectedEmprunteur = newValue;
              });
            },
            items: items,
          ),
        )
    );
  }
}

class dropDownLivre extends StatefulWidget {
  const dropDownLivre({super.key});

  @override
  State<dropDownLivre> createState() => _dropDownLivreState();
}

class _dropDownLivreState extends State<dropDownLivre> {
  var items;
  @override
  void initState() {
    super.initState();
    LoadData();
    items = livres.map((item) {
      return DropdownMenuItem<LivreData>(
        value: item,
        child: Text(item.titre),
      );
    }).toList();
    selectedLivre = LivreData("", 0, "", "");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 350,
        child:
        Padding(
          padding: EdgeInsets.all(0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(20)
              ),
            ),
            onChanged: (LivreData? newValue) {
              setState(() {
                selectedLivre = newValue;
              });
            },
            items: items,
          ),
        )
    );
  }
}