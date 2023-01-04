import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CalculatorDemo extends StatefulWidget {
  const CalculatorDemo({Key? key}) : super(key: key);

  @override
  State<CalculatorDemo> createState() => _CalculatorDemoState();
}

class _CalculatorDemoState extends State<CalculatorDemo> {
  String input = "";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(color: Colors.grey),
                        margin: EdgeInsets.only(
                          left: 5,
                          right: 5,
                          top: 10,
                        ),
                        padding: EdgeInsets.all(20),
                        child: Text(
                          input,
                          style: TextStyle(fontSize: 30),
                          textAlign: TextAlign.end,
                        )),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      fit: FlexFit.tight,
                      child: CalculatorButton(
                          color: Colors.grey,
                          content: "1",
                          onTap: () => setState(() {
                            input = "${input}1";
                          }))),
                  Flexible(
                      fit: FlexFit.tight,
                      child: CalculatorButton(
                          color: Colors.grey,
                          content: "2",
                          onTap: () => setState(() {
                            input = "${input}2";
                          }))),
                  Flexible(
                      fit: FlexFit.tight,
                      child: CalculatorButton(
                          color: Colors.grey,
                          content: "3",
                          onTap: () => setState(() {
                            input = "${input}3";
                          }))),
                  Flexible(
                      fit: FlexFit.tight,
                      child: CalculatorButton(
                          color: Colors.green,
                          content: "+",
                          onTap: () => setState(() {
                            input = "${input}+";
                          }))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: CalculatorButton(
                          color: Colors.grey,
                          content: "4",
                          onTap: () => setState(() {
                            input = "${input}4";
                          }))),
                  Flexible(
                      fit: FlexFit.loose,
                      child: CalculatorButton(
                          color: Colors.grey,
                          content: "5",
                          onTap: () => setState(() {
                            input = "${input}5";
                          }))),
                  Flexible(
                      fit: FlexFit.loose,
                      child: CalculatorButton(
                          color: Colors.grey,
                          content: "6",
                          onTap: () => setState(() {
                            input = "${input}6";
                          }))),
                  Flexible(
                      fit: FlexFit.loose,
                      child: CalculatorButton(
                          color: Colors.green,
                          content: "-",
                          onTap: () => setState(() {
                            input = "${input}-";
                          }))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: CalculatorButton(
                          color: Colors.indigo,
                          content: "Clear",
                          onTap: () => setState(() {
                            input = "";
                          }))),
                  Expanded(
                      flex: 2,
                      child: CalculatorButton(
                          color: Colors.indigo,
                          content: "=",
                          onTap: () => setState(() {
                            input = "";
                          }))),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CalculatorButton extends StatelessWidget {
  CalculatorButton({Key? key, required this.color, required this.content, required this.onTap}) : super(key: key);
  MaterialColor color;
  String content;
  void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(30),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
        child: Text(
          content,
          style: TextStyle(color: Colors.white, fontSize: 20, height: 1, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}