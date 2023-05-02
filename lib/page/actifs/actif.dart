import 'package:bts_emprunt/page/actifs/dataTable.dart';
import 'package:bts_emprunt/page/actifs/myForm.dart';
import 'package:flutter/material.dart';

class actif extends StatefulWidget {
  const actif({super.key});

  @override
  State<actif> createState() => _actifState();
}

class _actifState extends State<actif> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      backgroundColor: Color.fromRGBO(33, 149, 242, 0.1),
        body:Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                child:Center(child: Text("Les Emprunts", style: TextStyle(fontSize: 50))),
              ),
              myForm(),
              Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0), child: Stack(
                children: [
                  Center(child:Container(
                    width: 1500,
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white
                    ),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 15, 0, 25),
                      child: Text("Emprunts actifs", style: TextStyle(fontSize: 16, color: Colors.blue),),
                    ),
                  )),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Recherhe:"),
                            Container(
                              width: 500,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  )
                                ),
                              ),
                            ),
                            IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
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
                        width: 1500,
                        height: 400,
                        child: dataTable(),
                      )
                    ]
                  )
                ],
              )),
            ],
          )
      )
    );
  }
}