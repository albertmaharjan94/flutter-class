import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}
class _EditProductScreenState extends State<EditProductScreen> {

  TextEditingController productName = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();

  void addProduct() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "productName": productName.text,
      "productPrice": productPrice.text,
    }; // map of string key and any data type as values //
    final args = ModalRoute.of(context)!.settings.arguments;
    
    db.collection("products").doc(args.toString())
    .set(data).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product Updated"))
      );
    }); 
    
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      print(args);
      FirebaseFirestore db = FirebaseFirestore.instance;
      db.collection("products").doc(args.toString()) // args contains id
          .get().then((value){
          productName.text = value["productName"];
          productPrice.text = value["productPrice"];
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
            TextFormField(controller: productName,),
            TextFormField(controller: productPrice,),
            ElevatedButton(onPressed: (){
              addProduct();
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }

}