import 'package:bts_emprunt/dataBase.dart';
import 'package:bts_emprunt/object/livre.dart';
import 'package:flutter/material.dart';

late Future<List<LivreData>> taskList;
TextEditingController searchController = TextEditingController();
LoadData() async {
  taskList = dataBase.instance.livre(searchController.text);
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
            builder: (BuildContext context, AsyncSnapshot<List<LivreData>> snapshot) {
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
                            DataColumn(label: Text("Titre")),
                            DataColumn(label: Text("ID")),
                            DataColumn(label: Text("Etat")),
                            DataColumn(label: Text("Status")),
                          ],
                          rows: List.generate(snapshot.data!.length, (int index) => DataRow(cells: [
                            DataCell(Text(snapshot.data![index].titre)),
                            DataCell(Text(snapshot.data![index].id.toString())),
                            DataCell(Text(snapshot.data![index].etat)),
                            DataCell(Text(snapshot.data![index].status)),
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