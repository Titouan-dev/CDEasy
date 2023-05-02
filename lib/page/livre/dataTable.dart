import 'package:bts_emprunt/dataBase.dart';
import 'package:bts_emprunt/object/livre.dart';
import 'package:flutter/material.dart';

class dataTable extends StatefulWidget {
  @override
  State<dataTable> createState() => _dataTableState();

}

class _dataTableState extends State<dataTable> {
  late Future<List<Livre>> taskList;
  @override
  void initState() {
    super.initState();
    LoadData();
  }

  Future<List<Livre>> updateAndGetList() async {
    await dataBase.instance.database;
    // return the list here
    return dataBase.instance.livre().then((rows) {
      // build the list of words and then return it!
      List<Livre> res = [];
      for (var row in rows) {
        res.add(Livre.fromMap(row as Map<String, dynamic>));
      }
      return res;
    });
  }

  LoadData() async {
    taskList = dataBase.instance.livre();
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
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(20)),
                ),
              ),
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search)),
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
            builder: (BuildContext context, AsyncSnapshot<List<Livre>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                children = <Widget>[
                  SizedBox(
                    width: double.infinity,
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