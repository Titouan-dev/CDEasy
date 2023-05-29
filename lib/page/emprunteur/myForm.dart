

import 'package:bts_emprunt/dataBase.dart';
import 'package:bts_emprunt/page/emprunteur/emprunteur.dart';
import 'package:bts_emprunt/page/emprunteur/emprunteur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bts_emprunt/page/emprunteur/dataTable.dart';

import '../../object/emprunteur.dart';
import 'emprunteur.dart';



String? selectedValue = null;

late dataTable datatable;
class myForm extends StatefulWidget {
  final emprunteur emp;
  const myForm(this.emp);
  @override
  State<myForm> createState() => _myFormState();
}

class _myFormState extends State<myForm> {
  final prenomController = TextEditingController();
  final nomController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child:Container(
            width: 1500,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white),
            ),
          ),
        Padding(
          padding: EdgeInsets.all(10),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Prénom:"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                    child: Container(
                      width: 200,
                      child: TextFormField(
                        controller: prenomController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(20)),
                        ),
                      ),
                    )
                  ),
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nom:"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                    child: Container(
                      width: 200,
                      child: TextFormField(
                        controller: nomController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(20)),
                        ),
                      ),
                    )
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Status:"),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                    child: Container(
                      width: 250,
                      child: dropDownStatus(),
                    )
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 45, 0, 0),
                child: ElevatedButton(
                  child: Text("Ajouter"),
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(120, 70)),
                  ),
                  onPressed: () async {
                    dataBase.instance.insertEmprunteur(Emprunteur(prenomController.text, nomController.text, await dataBase.instance.emprunteurLastIndex()+1,selectedValue!));
                    prenomController.text = "";
                    nomController.text = "";
                    widget.emp.refresh();
                  },
                ),
              ),
            ],
          )
        ),
      ],
    );
  }
}


class dropDownStatus extends StatefulWidget {
  const dropDownStatus({super.key});

  @override
  State<dropDownStatus> createState() => _dropDownStatusState();
}

class _dropDownStatusState extends State<dropDownStatus> {

  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(
        child: Text("Etudiant"), value: "Etudiant"),
    DropdownMenuItem(child: Text("Enseignant"), value: "Enseignant"),
  ];


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
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
                value: selectedValue,
                validator: (value) => value == null ? "Renseigner le status" : null,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: menuItems,
              ),
          )
      );
  }
}