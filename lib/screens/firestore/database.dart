import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FireDatabaseScreen extends StatefulWidget {
  const FireDatabaseScreen({Key? key}) : super(key: key);
  @override
  _FireDatabaseScreenState createState() => _FireDatabaseScreenState();
}

class _FireDatabaseScreenState extends State<FireDatabaseScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> deleteProduct(String id) async {
    // DatabaseReference ref = FirebaseDatabase.instance.ref(); // delete this
    FirebaseFirestore db  = FirebaseFirestore.instance;
    showDialog(context: context, builder: (BuildContext context)=>
        AlertDialog(
          title: Text("Are you sure you want to delete?"),
          actions: [
            ElevatedButton(onPressed: (){
              db.collection("products").doc(id).delete()
              .then((value){
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Deleted"),));
              });

              Navigator.of(context).pop();
            }, child: Text("Delete")),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text("Cancel")),
          ],
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: db.collection("products").snapshots(),
          builder: (context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) return Text("Error");
            return ListView(
              children: [
                ...snapshot.data.docs.map((document)
                    {
                      ProductModel product = ProductModel.fromJson(document.data());
                      return ListTile(
                        trailing: Wrap(
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context)
                                    .pushNamed("/edit-product",
                                    arguments: document.id);
                              },
                              child: Icon(Icons.edit),
                            ),
                            InkWell(
                              onTap: (){
                                deleteProduct(document.id);
                              },
                              child: Icon(Icons.delete),
                            )
                          ],
                        ),
                        title : Text(
                          product.productName,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed("/add-product");
        },
      ),
    );
  }
}
