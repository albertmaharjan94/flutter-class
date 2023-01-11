import 'package:flutter/cupertino.dart';
class MakeRsText extends StatefulWidget {
  MakeRsText({Key? key, required this.price}) : super(key: key);
  String price;
  @override
  _MakeRsTextState createState() => _MakeRsTextState();
}
class _MakeRsTextState extends State<MakeRsText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Text("Rs. "+ widget.price),
    );
  }
}
