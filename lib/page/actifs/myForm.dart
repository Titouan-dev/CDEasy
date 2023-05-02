
import 'package:flutter/material.dart';

class myForm extends StatefulWidget {
  const myForm({super.key});
  @override
  State<myForm> createState() => _myFormState();

}

class _myFormState extends State<myForm>  {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(child: Container(
          width: 1500,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 10, 0, 25),
            child: Text("Nouvelle emprunt", style: TextStyle(fontSize: 16, color: Colors.blue),),
          ),
        )),
        Padding(padding:EdgeInsets.all(20), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text("Emprunteur:"),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                  child: Container(
                    width: 200,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text("Livre:"),
                Padding(
                  padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
                  child: Container(
                    width: 200,
                    child:TextField(
                      decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                )
              ],
            ),
            myDatePicker(),
            Padding(
                padding: EdgeInsets.fromLTRB(5, 40, 15, 0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 70)),
                    ),
                    child: Text("Ajouter"))),

          ],
        ))
      ],
    );
  }
}

class myDatePicker extends StatefulWidget {
  const myDatePicker({super.key});

  @override
  State<myDatePicker> createState() => _myDatePickerState();
}

class _myDatePickerState extends State<myDatePicker> {
  DateTime currentDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text("Date de retour:"),
        Padding(
          padding: EdgeInsets.fromLTRB(5, 20, 15, 0),
          child: OutlinedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(200, 50)),
            ),
            onPressed: () => _selectDate(context),
            child: Text(currentDate.toString().split(" ")[0]),
          ),
        ),
      ],
    );
  }
}