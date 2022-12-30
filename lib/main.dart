// import 'package:first_app_a/screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app_a/screens/add_task.dart';
import 'package:first_app_a/screens/calculator.dart';
import 'package:first_app_a/screens/database.dart';
import 'package:first_app_a/screens/edit_task.dart';
import 'package:first_app_a/screens/firestore/add_product.dart';
import 'package:first_app_a/screens/firestore/database.dart';
import 'package:first_app_a/screens/firestore/edit_product.dart';
import 'package:first_app_a/screens/homepage.dart';
import 'package:first_app_a/screens/input_demo.dart';
import 'package:first_app_a/screens/layout_demo.dart';
import 'package:first_app_a/screens/registration/homescreen.dart';
import 'package:first_app_a/screens/registration/login.dart';
import 'package:first_app_a/screens/registration/register.dart';
import 'package:first_app_a/viewmodels/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductViewModel>
          (create: (_)=>ProductViewModel())
      ],
      child: MaterialApp(
        title: 'Flutter 123',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        // home: LoginScreen(),
        initialRoute: "/product",
        routes: {
          "/login": (BuildContext context) => LoginScreen(),
          "/register": (BuildContext context) => RegisterScreen(),
          "/home": (BuildContext context) => HomeScreen(),
          "/task": (BuildContext context) => DatabaseScreen(),
          "/add-task": (BuildContext context) => AddTaskScreen(),
          "/edit-task": (BuildContext context) => EditTaskScreen(),


          // add these line
          "/product":(BuildContext context) => FireDatabaseScreen(),
          "/add-product":(BuildContext context) => AddProductScreen(),
          "/edit-product":(BuildContext context) => EditProductScreen(),
        },
      ),
    );
  }
}








class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int idx = 0;
  List<Widget> home = [
    // Home(),
    InputDemo(),
    LayoutDemo(),
    CalculatorDemo(),
    Text("Phone")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Homepage"),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (index){
          setState(() {
            idx = index;
          });
        },
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message),
            label: "Message"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.email),
              label: "Email"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.call),
              label: "Phone"
          ),
        ],
      ),
      body: home[idx]
      // Container(
      //   decoration: BoxDecoration(
      //      color: Colors.blue,
      //     border: Border.all(color: Colors.black, width: 10),
      //     borderRadius: BorderRadius.circular(10)
      //   ),
      //   margin: EdgeInsets.all(10),
      //   padding: EdgeInsets.symmetric(
      //     horizontal: 10, vertical: 5
      //   ),
      //   child: Text("Body"),
      // )
    );
  }
}



