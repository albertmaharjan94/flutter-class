import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputDemo extends StatefulWidget {
  const InputDemo({Key? key}) : super(key: key);

  @override
  State<InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  TextEditingController num1 = new TextEditingController();
  TextEditingController num2 = new TextEditingController();
  //if in android studio ctrl + d to duplicate line
  TextEditingController date = new TextEditingController();
  String result = "";
  String operation = "";
  bool checkBox = false;
  List<String> selection = ["Nepal", "India", "China"];
  String selectionItem = "";

  @override
  void initState() {
    setState(() {
      selectionItem = selection[0];
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton(
          value: selectionItem,
          items: selection
              .map((value) =>
              DropdownMenuItem(value: value.toString(), child: Text(value)))
              .toList(),
          onChanged: (value) {
            setState(
                  () {
                selectionItem = value.toString();
              },
            );
          },
        ),
        TextFormField(
          controller: date,
          readOnly: true,
          onTap: () async {
            DateTime? dateInput = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1990),
              lastDate: DateTime(2100),
            );
            if (dateInput != null) {
              String formattedDate = DateFormat('yyyy-MM-dd').format(dateInput);
              setState(() {
                date.text = dateInput.toString();
              });
            }
          },
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: num1,
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: TextField(
                controller: num2,
              ),
            ),
          ],
        ),
        RadioListTile(
          value: "add",
          groupValue: operation,
          title: Text("Addition"),
          onChanged: (String? value) {
            setState(() {
              operation = value.toString();
            });
          },
        ),
        RadioListTile(
          value: "sub",
          groupValue: operation,
          title: Text("Subtraction"),
          onChanged: (String? value) {
            setState(() {
              operation = value.toString();
            });
          },
        ),
        RadioListTile(
          value: "multiply",
          groupValue: operation,
          title: Text("Multiply"),
          onChanged: (String? value) {
            setState(() {
              operation = value.toString();
            });
          },
        ),
        RadioListTile(
          value: "div",
          groupValue: operation,
          title: Text("Division"),
          onChanged: (String? value) {
            setState(() {
              operation = value.toString();
            });
          },
        ),
        CheckboxListTile(
          title: Text("Check box"),
          value: checkBox,
          onChanged: (bool? value) {
            setState(() {
              checkBox = !checkBox;
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (operation == "add") {
              setState(() {
                result =
                    (int.parse(num1.text) + int.parse(num2.text)).toString();
              });
            }
            if (operation == "sub") {
              setState(() {
                result =
                    (int.parse(num1.text) - int.parse(num2.text)).toString();
              });
            }
            if (operation == "multiply") {
              setState(() {
                result =
                    (int.parse(num1.text) * int.parse(num2.text)).toString();
              });
            }
            if (operation == "div") {
              setState(() {
                result =
                    (int.parse(num1.text) / int.parse(num2.text)).toString();
              });
            }
          },
          child: Text("Output"),
        ),
        Text(result),
        InkWell(
          onTap: () {
            print("click me");
          },
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(color: Colors.amber),
            child: Text("Click me"),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            print("Single Tap");
          },
          onDoubleTap: () {
            print("Double Tap");
          },
          child: Container(
            height: 30,
            width: 100,
            decoration: BoxDecoration(color: Colors.blueAccent),
            child: Text("Click me 2"),
          ),
        ),
      ],
    );
  }
}