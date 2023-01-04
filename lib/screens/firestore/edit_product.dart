import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductscreenstate();
}

class _EditProductscreenstate extends State<EditProductScreen> {
  TextEditingController productName = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  Future<void> addProduct() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final data = {
      "productName": productName.text,
      "productPrice": productPrice.text,
    };
    final args = ModalRoute.of(context)!.settings.arguments;
    db.collection("products").doc(args.toString())
        .set(data).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Product Added"))
      );
    });
  }

  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      print(args);
      FirebaseFirestore db = FirebaseFirestore.instance;
          db.collection("Products").doc(args.toString()).get()
          .then((data){
            productName.text = data["productName"];
            productPrice.text= data["productPrice"];
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
