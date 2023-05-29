import 'package:bts_emprunt/dataBase.dart';
import 'package:bts_emprunt/object/livre.dart';
import 'package:bts_emprunt/page/livre/livre.dart';
import 'package:flutter/material.dart';
late DateTime currentDate;
String? selectedValue = null;
String? selectedAuteur = null;
class myDatePicker extends StatefulWidget {
  const myDatePicker({super.key});

  @override
  State<myDatePicker> createState() => _myDatePickerState();
}

class _myDatePickerState extends State<myDatePicker> {

  Future<void> _selectDate(BuildContext context) async {
    currentDate = DateTime.now();
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
    currentDate = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text("Date d'achat:"),
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

class dropDownEtat extends StatefulWidget {
  dropDownEtat({super.key});



  @override
  State<dropDownEtat> createState() => _dropDownEtatState();
}

class _dropDownEtatState extends State<dropDownEtat> {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text("Occasion mauvais étât"), value: "Occasion mauvais étât"),
    DropdownMenuItem(
        child: Text("Occasion bon étât"), value: "Occasion bon étât"),
    DropdownMenuItem(child: Text("Neuf"), value: "Neuf"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Etat:"),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value == null ? "Renseigner l'étât du livre" : null,
                    dropdownColor: Colors.white,
                    value: selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedValue = newValue!;
                      });
                    },
                    items: menuItems),
              )
            ]));
  }
}

class myForm extends StatefulWidget {
  final Livre livre;
  const myForm(this.livre);

  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  final titreController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Titre du livre:"),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                child: SizedBox(
                  width: 250,
                  child: TextFormField(
                    controller: titreController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      //labelText: 'Entrez le nom ici',
                      //hintText: 'Entrez le nom ici',
                    ),
                    autofocus: false,
                  ),
                ),
              ),
            ]),
        dropDownEtat(),
        myDatePicker(),
        Padding(
            padding: EdgeInsets.fromLTRB(5, 40, 15, 0),
            child: ElevatedButton(
                onPressed: () async {
                  dataBase.instance.insertLivre(LivreData(titreController.text, await dataBase.instance.livreLastIndex()+1, selectedValue.toString(), "En Stock"));
                  titreController.text = "";
                  widget.livre.refresh();
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(120, 70)),
                ),
                child: Text("Ajouter"))
        ),
      ],
    );
  }
}


class dropDownAuteur extends StatefulWidget {
  dropDownAuteur({super.key});



  @override
  State<dropDownAuteur> createState() => _dropDownAuteurState();
}

class _dropDownAuteurState extends State<dropDownAuteur> {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text("Occasion mauvais étât"), value: "Occasion mauvais étât"),
    DropdownMenuItem(
        child: Text("Occasion bon étât"), value: "Occasion bon étât"),
    DropdownMenuItem(child: Text("Neuf"), value: "Neuf"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Etat:"),
              Padding(
                padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    validator: (value) =>
                    value == null ? "Renseigner l'étât du livre" : null,
                    dropdownColor: Colors.white,
                    value: selectedAuteur,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAuteur = newValue!;
                      });
                    },
                    items: menuItems),
              )
            ]));
  }
}
