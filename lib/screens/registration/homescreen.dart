import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: InkWell(
              onTap: (){

              },
              child: Text("Signout"),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Home",
                  icon: Icon(Icons.home),
                ),
                Tab(
                  text: "Phone",
                  icon: Icon(Icons.phone),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Text("Home Tab Clicked"),
              Text("Phone Tab Clicked")
            ],
          ),
        ));
  }
}
