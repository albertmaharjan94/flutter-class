import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}
class _AddTaskScreenState extends State<AddTaskScreen> {
  TextEditingController taskId = new TextEditingController();
  TextEditingController taskName = new TextEditingController();
  Future<void> saveTask() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    await ref.child("tasks").child(taskId.text).set(
        {
          "taskName": taskName.text
        }
    ).then((value){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task saved successful"))
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(controller: taskId,),
            TextFormField(controller: taskName,),
            ElevatedButton(onPressed: (){
              saveTask();
            }, child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
}
