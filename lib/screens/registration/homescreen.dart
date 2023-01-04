import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _Homescreenstate();
}

class _Homescreenstate extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3, // size of tab Note: tabbar must be under tabcontroller or have a tab controller assigned to it
        child: Scaffold(
          appBar: AppBar(
            bottom:  // the Length of the tabbar must be the same as length of tabcontroller
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.message)),
                Tab(icon: Icon(Icons.phone)),
              ],
            ),
            title: const Text('Working with tabs'),
          ),
          body: // the length of the tabbarview must be the same as tabbar
          const TabBarView(
            children: [
              Icon(Icons.home),
              Icon(Icons.message),
              Icon(Icons.phone),
            ],
          ),
        ),
      ),
    );
  }
}