
import 'package:bts_emprunt/page/emprunteur/dataTable.dart';
import 'package:bts_emprunt/page/emprunteur/myForm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class emprunteur extends StatefulWidget {
  const emprunteur({super.key});

  State<emprunteur> createState() => _emprunteurState();
}

class _emprunteurState extends State<emprunteur> {
  @override
  Widget build(BuildContext context) {
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
              child:  myForm(),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0,25, 0, 0),
              child: Stack(
                children: [
                  Center(child:Container(
                    width: 1500,
                    height: 499,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                  )),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Recherche:"),
                            Container(
                              width: 900,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                ),
                              ),
                            ),
                            IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Container(
                          width: 1200,
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 350,
                        width: 1500,
                        child: dataTable(),
                      )
                    ],
                  ),
                ],
              )
            )
          ]
        )
      ),
    );
  }
}