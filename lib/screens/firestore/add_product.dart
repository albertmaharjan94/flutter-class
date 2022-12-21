import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}
class _AddProductScreenState extends State<AddProductScreen> {

  TextEditingController productName = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  Future<void> addProduct() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "productName": productName.text,
      "productPrice": productPrice.text,
    }; // map of string key and any data type as values //
    db.collection("products").add(data).then((value){
      print(value.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product added successfully"))
      );
    });

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
