import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDemo extends StatefulWidget {
  const InputDemo({Key? key}) : super(key: key);
  @override
  _InputDemoState createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  TextEditingController name = new TextEditingController(text: "Hello");
  TextEditingController num1 = new TextEditingController();
  TextEditingController num2 = new TextEditingController();

  TextEditingController date = new TextEditingController();

  String result = "";
  String operation = "";
  bool checkBox = false;
  List<String> dropDownList = ["Nepal", "India", "China"];
  String selected = "";

  @override
  void initState() {
    setState(() {
      selected = dropDownList[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: num1,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: num2,
                  ),
                ),
              ),
            ],
          ),
          RadioListTile(
              title: Text("Add"),
              value: "add",
              groupValue: operation,
              onChanged: (String? value) {
                setState(() {
                  operation = value.toString();
                });
              }
          ),
          RadioListTile(
              title: Text("Substract"),
              value: "sub",
              groupValue: operation,
              onChanged: (String? value) {
                setState(() {
                  operation = value.toString();
                });
              }
          ),
          ElevatedButton(
              onPressed: () {
                if(operation == "add"){
                  setState(() {
                    result =
                        (int.parse(num1.text) + int.parse(num2.text)).toString();
                  });
                }
                if(operation == "sub"){
                  setState(() {
                    result =
                        (int.parse(num1.text) - int.parse(num2.text)).toString();
                  });
                }
              },
              child: Text("Compute")),
          Container(
            margin: EdgeInsets.all(10),
            child: Text("$result"),
          ),
          CheckboxListTile(
              title: Text("Checkbox"),
              value: checkBox,
              onChanged: (bool? value){
                setState(() {
                  checkBox = !checkBox;
                });
              }
          ),
          TextFormField(
            controller: date,
            onTap: () async {
              DateTime? dateInput = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100)
              );
              if(dateInput!=null){
                String formattedDate = DateFormat("yyyy-MM-dd")
                    .format(dateInput);
                setState(() {
                  date.text = formattedDate;
                });
              }
              print(dateInput);
            },
          ),
          DropdownButton(
            value: selected,
              items: dropDownList.map((e) =>
              DropdownMenuItem(
                value: e.toString(),
                  child: Text(e.toString())
              ))
              .toList(),
              onChanged: (value){
                setState(() {
                  selected = value.toString();
                });
              }
            ),
            InkWell(
              onTap: (){
                print("Tapped");
              },
              child: Container(
                color: Colors.blueAccent,
                height: 30,
                width: 200,
                child: Text("Click me"),
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: (){
                print("Single tap");
              },
              onDoubleTap: (){
                print("Double tap");
              },
              child: Container(
                height: 30,
                width: 200,
                color: Colors.red,
                child: Text("Click me 2"),
              ),
            )
        ],
      ),
    );
  }
}
