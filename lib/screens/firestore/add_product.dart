import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_a/models/product_model.dart';
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
  void addProduct() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    final data = ProductModel(
        productName: productName.text,
        productPrice: productPrice.text
    );

    db.collection("products").add(data.toJson()).then((value){
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
