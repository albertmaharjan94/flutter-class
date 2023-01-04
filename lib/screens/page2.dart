// import 'package:arithmetic/screens/page1.dart';
import 'package:first_app_a/screens/page1.dart';
import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(title: Text("Page 2"),),
      body: Column(
        children: [
          Container(child: Text("Page 2 content"),),
          ElevatedButton(onPressed: (){
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Page1(),
              ),
            );
          }, child: Text("Change"))
        ],
      ),
    );
  }
}