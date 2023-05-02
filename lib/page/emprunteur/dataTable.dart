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
            DataColumn(label: Text('Prenom')),
            DataColumn(label: Text('Nom')),
            DataColumn(label: Text('ID')),
            DataColumn(label: Text("Status")),
            DataColumn(label: Text("Editer"))
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("Jeremy")),
              DataCell(Text("Hayotte")),
              DataCell(Text("1")),
              DataCell(Text("Etudiant")),
              DataCell(IconButton(onPressed: () {}, icon: Icon(Icons.edit)))
            ]),
            DataRow(cells: [
              DataCell(Text("Sacha")),
              DataCell(Text("Barbet")),
              DataCell(Text("2")),
              DataCell(Text("Etudiant")),
              DataCell(IconButton(onPressed: () {}, icon: Icon(Icons.edit)))
            ]),
          ]
      ),
    ]);
  }
}