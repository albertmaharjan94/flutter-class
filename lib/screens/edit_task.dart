import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({Key? key}) : super(key: key);

  @override
  State<EditTaskScreen> createState() => _EditTaskscreenstate();
}

class _EditTaskscreenstate extends State<EditTaskScreen> {
  TextEditingController taskid = new TextEditingController();
  TextEditingController taskName = new TextEditingController();
  Future<void> editTask() async{
  }
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      print(args);
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      ref
          .child("tasks")
          .child(args.toString())
          .get()
          .then((data){
        var parseData = data.value as Map;
        taskid.text =args.toString();
        taskName.text = parseData["taskName"].toString();
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
            TextFormField(controller:taskid ,readOnly: true,),
            TextFormField(controller:taskName ,),
            ElevatedButton(onPressed: (){
              editTask();
            }, child: Text("Edit task"))
          ],
        ),
      ),
    );
  }
}