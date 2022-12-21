import 'package:flutter/cupertino.dart';
class CalculatorDemo extends StatefulWidget {
  const CalculatorDemo({Key? key}) : super(key: key);
  @override
  _CalculatorDemoState createState() => _CalculatorDemoState();
}
class _CalculatorDemoState extends State<CalculatorDemo> {
  @override
  Widget build(BuildContext context) {
    return ColumnDemo();
  }
}
class ColumnDemo extends StatelessWidget {
  const ColumnDemo({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Text 1", style: TextStyle(fontSize: 100),),
        Text("Text 2", style: TextStyle(fontSize: 100),),
      ],
    );
  }
}
