import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaseScreen extends StatefulWidget {
  const DatabaseScreen({Key? key}) : super(key: key);

  @override
  State<DatabaseScreen> createState() => _Databasescreenstate();
}

class _Databasescreenstate extends State<DatabaseScreen> {
  DatabaseReference ref = FirebaseDatabase.instance.ref();
  var data = [];
  @override
  void initState() {
    ref.child("tasks").onValue.listen((event) {
      var snapshot = event.snapshot;
      print(snapshot.children);
      setState(() {
        data = snapshot.children.toList();
      });
    });
    super.initState();
  }

  void deleteTask(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Are you sure you want to delete"),
        actions: [
          ElevatedButton(
            onPressed: () {
              DatabaseReference ref = FirebaseDatabase.instance.ref();
              ref.child("tasks").child(id).remove();
              Navigator.of(context).pop();
            },
            child: Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/add_task");
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          ...data.map((e) =>
              ListTile(
            title: Text(
              e.value["taskName"],
              style: TextStyle(fontSize: 40),
            ),
            trailing: Wrap(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed('/edit_task', arguments: e.key);
                  },
                  child: Icon(Icons.edit),
                ),
                InkWell(
                  onTap: () {
                    deleteTask(e.key);
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
