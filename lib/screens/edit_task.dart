import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);
  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}
class _EditTaskScreenState extends State<EditTaskScreen> {
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      print(args);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref.child("tasks").child(args.toString()).get().then((data){
        var parseData = data.value as Map;
        taskId.text = args.toString();
        taskName.text = parseData["taskName"];
      });
    });
    super.initState();
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
