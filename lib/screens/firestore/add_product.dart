import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/product_model.dart';
class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);
  @override
  State<AddProductScreen> createState() => _AddProductscreenstate();
}
class _AddProductscreenstate extends State<AddProductScreen> {
  TextEditingController productName = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  Future<void> saveProduct() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = ProductModel(
        productName: productName.text,
        productPrice: productPrice.text,
        imagePath: imagePath ?? "",
        imageUrl:  imageUrl ?? ""
    );

    db.collection("products").add(data.toJson()).then((value) {
      print("Added Data with ID: ${value.id}");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product Added"))
      );
    });
  }
  final ImagePicker _picker = ImagePicker();
  File? image;
  String? imagePath;
  String? imageUrl;
  Future<void> _pickImage(ImageSource source) async {
    var selected = await _picker.pickImage(source: source, imageQuality: 50);
    if(selected !=  null){
      print(selected.path);
      Reference storage = FirebaseStorage.instance.ref();

      String dt = DateTime.now()
          .millisecondsSinceEpoch.toString();

      storage.child("products")
          .child("product-$dt.jpg").putFile(File(selected.path))
      .then((p0){
        // url
        p0.ref.getDownloadURL().then((url) {
          print(url);
          setState(() {
            imagePath = p0.ref.fullPath;
            imageUrl = url;
          });
        });
      });


      setState((){
        image = File(selected.path);
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
            imageUrl == null ?
                Container()
                :
                Image.network(imageUrl!),
            Wrap(
              children: [
                ElevatedButton(onPressed:(){
                  _pickImage(ImageSource.camera);
                }, child: Icon(Icons.camera)),
                ElevatedButton(onPressed:(){
                  _pickImage(ImageSource.gallery);
                }, child: Icon(Icons.photo)),
              ],
            ),
            ElevatedButton(onPressed: (){
              saveProduct();
            }, child: Text("Save"))
          ],
        ),
      ),
    );
  }
}
