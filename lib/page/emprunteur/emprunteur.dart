
import 'package:bts_emprunt/page/emprunteur/dataTable.dart';
import 'package:bts_emprunt/page/emprunteur/myForm.dart';
import 'package:bts_emprunt/page/livre/livre.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
late dataTable datatable;
class emprunteur extends StatefulWidget {
  const emprunteur({super.key});
  @override
  State<emprunteur> createState() => _emprunteurState();

  void refresh() {
    datatable.refresh();
  }
}

class _emprunteurState extends State<emprunteur> {
  @override
  Widget build(BuildContext context) {
    datatable = dataTable();
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 149, 242, 0.1),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          children: [
            const Center(
              child: Text("Les emprunteurs", style: TextStyle(fontSize: 50),),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child:  myForm(this.widget),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0,25, 0, 0),
              child: Stack(
                children: [
                  Center(child:Container(
                    height: 499,
                    width: 1500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                  )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [datatable],
                    ),
                  )
                ],
            )
            )
          ]
        )
      ),
    );
  }
}