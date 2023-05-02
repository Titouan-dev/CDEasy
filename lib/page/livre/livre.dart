import 'package:bts_emprunt/page/livre/dataTable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bts_emprunt/page/livre/myForm.dart';


class Livre extends StatefulWidget {
  const Livre({super.key});

  @override
  State<Livre> createState() => _Livre();
}

class _Livre extends State<Livre> {
  @override
  Widget build(BuildContext context) {
    String? selectedValue = null;
    dataTable datatable = dataTable();
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
                    child: const myForm(),
                  )
                ]),
              ),
              ElevatedButton(onPressed: () {datatable.loadData()}, child: Text("test")),
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