import 'package:bts_emprunt/dataBase.dart';
import 'package:flutter/material.dart';

import '../../object/emprunteur.dart';

late Future<List<Emprunteur>> taskList;
TextEditingController searchController = new TextEditingController();

LoadData() async {
  taskList = dataBase.instance.emprunteur(searchController.text);
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
  @override
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Recherche:"),
            Container(
              width: 900,
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )
                ),
              )
            ),
            IconButton(onPressed: () {widget.refresh();}, icon: Icon(Icons.search)),
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
            future: taskList,
            builder: (BuildContext context, AsyncSnapshot<List<Emprunteur>> snapshot) {
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
                          DataColumn(label: Text("Prénom")),
                          DataColumn(label: Text("Nom")),
                          DataColumn(label: Text("Status")),
                          DataColumn(label: Text("ID")),
                        ],
                        rows: List.generate(snapshot.data!.length, (index) =>
                          DataRow(cells: [
                            DataCell(Text(snapshot.data![index].prenom)),
                            DataCell(Text(snapshot.data![index].nom)),
                            DataCell(Text(snapshot.data![index].status)),
                            DataCell(Text(snapshot.data![index].id.toString())),
                          ])
                        ),
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
              }return Center(
                child:Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: children,
                  ),
                ),
              );
            }
          ),
        )
      ],
    );
  }
}