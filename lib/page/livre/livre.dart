import 'package:bts_emprunt/page/livre/dataTable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bts_emprunt/page/livre/myForm.dart';


late dataTable datatable;
class Livre extends StatefulWidget {
  const Livre({super.key});
  @override
  State<Livre> createState() => _Livre();

  void refresh() {
    datatable.refresh();
  }
}

class _Livre extends State<Livre> {
  @override
  Widget build(BuildContext context) {
    datatable = dataTable();
    String? selectedValue = null;
    return Scaffold(
      backgroundColor: Color.fromRGBO(33, 149, 242, 0.1),
        body: Padding(
            padding: EdgeInsets.all(50),
            child: Column(children: [
              const Center(
                child: Text("Mes Livres", style: TextStyle(fontSize: 50)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Stack(children: [
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
                    child: myForm(this.widget),
                  )
                ]),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 1500,
                          height: 500,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child:Column(
                          children: [
                            datatable
                          ],
                        ),
                      )
                    ],
                  ))
            ])));
  }
}