import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';

import 'services/api.dart';

class guess_teacher_age extends StatefulWidget {
  const guess_teacher_age({Key? key}) : super(key: key);

  @override
  _guess_teacher_ageState createState() => _guess_teacher_ageState();
}

class _guess_teacher_ageState extends State<guess_teacher_age> {

  int year = 0;
  int month = 0;
  bool guess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GUESS TEACHER'S AGE"),
      ),

      body: Container(
        color: Colors.green[100],
        child: Center(
          child: guess == true? buildguesstrue() : buildGuess(),
        ),
      ),

    );
  }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg, style: Theme.of(context).textTheme.bodyText2),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> guessbutton() async {
    var data = (await Api().submit("guess_teacher_age",{'year':year,
    'month':month})) as Map <String , dynamic>;
    if (data == null) {
      return;
    }
    else {
      String text = data["text"];
      bool value = data["value"];
      if(value == true) {
        setState(() {
          guess = true;
        });
      }
      else {
        _showMaterialDialog("ผลการทาย", text);
      }
    }
  }

  Column buildguesstrue() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("อายุอาจารย์",style: TextStyle(fontSize: 30.0),),
            Text("$year ปี $month เดือน",style: TextStyle(fontSize: 30.0),),
            Icon(Icons.done_outline,color: Colors.green,size: 50.0,),
          ],
        );
  }

  Column buildGuess() {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("อายุวันโนสุขังพลัง",style: TextStyle(fontSize: 40.0),),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Card(
                child: Column(
                  children: [
                    SpinBox(
                      min: 0,
                      max: 100,
                      value: 0,
                      onChanged: (value) => setState(() {
                        year = value as int;
                      }),
                      decoration: InputDecoration(
                        labelText: "ปี"
                      ),
                    ),
                    SpinBox(
                      min: 0,
                      max: 11,
                      value: 0,
                      onChanged: (value) => setState(() {
                        month = value as int;
                      }),
                      decoration: InputDecoration(
                        labelText: "เดือน"
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: OutlinedButton(onPressed: guessbutton , child: Text("ทาย")),
                    )
                  ],
                ),
              ),
            ),
          ],
        );
  }
}
