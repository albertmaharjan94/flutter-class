import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);
  @override
  _DatabaseScreenState createState() => _DatabaseScreenState();
}

class _DatabaseScreenState extends State<DatabaseScreen> {
  var data = [];
  @override
  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    ref.child("tasks").onValue.listen((event) {
      var snapshot = event.snapshot;
      setState(() {
        data = snapshot.children.toList();
      });
    });
    super.initState();
  }

  Future<void> deleteTask(String id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    showDialog(context: context, builder: (BuildContext context)=>
      AlertDialog(
        title: Text("Are you sure you want to delete?"),
        actions: [
          ElevatedButton(onPressed: (){
            ref.child("tasks").child(id).remove().then((value) =>
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Task Deleted")))
            );
            Navigator.of(context).pop();
          }, child: Text("Delete")),
          ElevatedButton(onPressed: (){
            Navigator.of(context).pop();
          }, child: Text("Cancel")),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/add-task");
        },
      ),
      body: ListView(
        children: [
          ...data.map((e) =>
               ListTile(
                 title: Text(
                    e.value["taskName"],
                    style: TextStyle(fontSize: 30),
                  ),
                 trailing: Wrap(
                   children: [
                     InkWell(onTap: (){
                        Navigator.of(context)
                            .pushNamed("/edit-task", arguments: e.key);
                     },child: Icon(Icons.edit),),
                     InkWell(onTap: (){
                        deleteTask(e.key); //
                     },child: Icon(Icons.delete),),
                   ],
                 ),
               ),
              )
        ],
      ),
    );
  }
}
