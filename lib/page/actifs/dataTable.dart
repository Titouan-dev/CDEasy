import 'dart:io';

import 'package:bts_emprunt/object/emprunts.dart';
import 'package:bts_emprunt/object/livre.dart';
import 'package:flutter/material.dart';
import 'package:bts_emprunt/dataBase.dart';

late Future<List<Emprunt>> taskList;
TextEditingController searchController = TextEditingController();
LoadData() async {
  taskList = dataBase.instance.emprunt(searchController.text);
}

class dataTable extends StatefulWidget {
  dataTable({super.key});
  @override
  State<dataTable> datatable = _dataTableState();
  State<dataTable> createState() => datatable;

  void refresh() {
    datatable.setState(() {
      LoadData();
    });
  }
}

class _dataTableState extends State<dataTable> {

  void refresh() {
    setState(() {
      LoadData();
    });
  }

  @override
  void initState() {
    super.initState();
    LoadData();
  }

  @override
  Widget build(BuildContext context) {

    return  Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Recheche:"),
            Container(
              width: 900,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(20)),
                ),
              ),
            ),
            IconButton(
                onPressed: () {widget.refresh();},
                icon: const Icon(Icons.search)
            ),
          ],
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
          height: 390,
          child: FutureBuilder(
            future: taskList, // a previously-obtained Future<String> or null
            builder: (BuildContext context, AsyncSnapshot<List<Emprunt>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  SizedBox(
                    height: 390,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text("Emprunteur")),
                          DataColumn(label: Text("Livre")),
                          DataColumn(label: Text("ID du Livre")),
                          DataColumn(label: Text("Temps")),
                          DataColumn(label: Text("Retour")),
                        ],
                        rows: List.generate(snapshot.data!.length, (int index) => DataRow(cells: [
                          DataCell(Text(snapshot.data![index].emprunteur)),
                          DataCell(Text(snapshot.data![index].livre)),
                          DataCell(Text(snapshot.data![index].livreId.toString())),
                          DataCell(
                              Padding(
                                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                                  child: LinearProgressIndicator(backgroundColor: Color.fromRGBO(33, 149, 242, 0.1), color: Colors.blue, value: snapshot.data![index].getTime())
                              )),
                          DataCell( IconButton(onPressed: () async {
                            dataBase.instance.updateEmprunts(Emprunt(snapshot.data![index].id, snapshot.data![index].emprunteurId, snapshot.data![index].livreId, snapshot.data![index].startDate, snapshot.data![index].supposedEndDate, DateTime.now().toIso8601String(), snapshot.data![index].emprunteur, snapshot.data![index].livre));
                            dataBase.instance.updateLivre(LivreData(snapshot.data![index].livre, snapshot.data![index].livreId, await dataBase.instance.getLivre(snapshot.data![index].livreId), "En Stock"));
                            widget.refresh();
                          }, icon: Icon(Icons.undo),))
                        ])),
                      ),
                    ),
                  )
                ];
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('Awaiting result...'),
                  ),
                ];
              }
              return Center(
                child:Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: children,
                  ),
                ),
              );
            },
          ),
        )],
    );
  }
}