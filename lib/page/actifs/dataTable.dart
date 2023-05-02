import 'package:flutter/material.dart';

class dataTable extends StatefulWidget {
  @override
  State<dataTable> createState() => _dataTableState();
}

class _dataTableState extends State<dataTable> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      DataTable(
          columns: [
            DataColumn(label: Text('Emprunteur')),
            DataColumn(label: Text('Livre')),
            DataColumn(label: Text('ID du livre')),
            DataColumn(label: Text("Temp")),
            DataColumn(label: Text("Retour")),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("Jeremy Hayotte")),
              DataCell(Text("La poupée")),
              DataCell(Text("1")),
              DataCell(
                Padding(
                  padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                  child: LinearProgressIndicator(backgroundColor: Color.fromRGBO(33, 149, 242, 0.1), color: Colors.blue, value: 0.5)
              )),
              DataCell( IconButton(onPressed: (){}, icon: Icon(Icons.undo),))
            ]),
          ]
      ),
    ]);
  }
}