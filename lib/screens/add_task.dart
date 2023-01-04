import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskscreenstate();
}

class _AddTaskscreenstate extends State<AddTaskScreen> {
  TextEditingController id = new TextEditingController();
  TextEditingController task = new TextEditingController();
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  Future<void> saveTask() async {
    try {
      await ref
          .child("tasks")
          .child(id.text)
          .set({"taskName": task.text, "does": "New"});
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Task added")));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: id,
            ),
            TextFormField(
              controller: task,
            ),
            ElevatedButton(
                onPressed: () {
                  saveTask();
                  Navigator.of(context).pushNamed('/task');
                },
                child: Text('Save'))
          ],
        ),
      ),
    );
  }
}