import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

    final data = ProductModel(
        productName: productName.text,
        productPrice: productPrice.text,
        imagePath: imagePath ?? "",
        imageUrl: imageUrl ?? ""
    );

    db.collection("products").add(data.toJson()).then((value){
      print(value.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Product added successfully"))
      );
    });

  }


  File? image;
  String? imageUrl;
  String? imagePath;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    var selected = await _picker.pickImage(source: source,
        imageQuality: 50);
    if(selected != null){
      print(selected.path);
      setState(() {
        image = File(selected.path);
      });
      Reference storageRef = FirebaseStorage.instance.ref();
      String dt = DateTime.now()
          .millisecondsSinceEpoch.toString();
      storageRef.child("products")
          .child("product-$dt.jpg").putFile(File(selected.path))
          .then((p0) async {
            String url = await p0.ref.getDownloadURL();
            print(url);
            setState(() {
              imagePath = p0.ref.fullPath;
              imageUrl = url;
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(controller: productName,),
            TextFormField(controller: productPrice,),
            if(imageUrl!=null) Image.network(imageUrl!, height: 200,),

            ElevatedButton(onPressed: (){
              _pickImage(ImageSource.camera);
            }, child: Icon(Icons.camera)),
            ElevatedButton(onPressed: (){
              _pickImage(ImageSource.gallery);
            }, child: Icon(Icons.photo)),
            ElevatedButton(onPressed: (){
              addProduct();
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }

}
