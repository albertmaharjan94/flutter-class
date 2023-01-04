import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:first_app_a/repositories/product_repository.dart';
import 'package:first_app_a/services/notification_service.dart';
import 'package:first_app_a/viewmodels/product_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              _productRepository.deleteProduct(id)
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

  ProductRepository _productRepository = ProductRepository();
  late ProductViewModel _productViewModel;
  @override
  void initState() {
    // TODO: implement initState
    _productViewModel = Provider.of<ProductViewModel>
      (context, listen: false);
    _productViewModel.productData();

    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print(message);
      }
    });
    FirebaseMessaging.instance.getToken().then((value) {
      String? token = value;
      print("fcm: " + token.toString());

      // I/flutter (0): fcm: eOIt5z4dSpm3Y7UESKUBEx...my8

      // it shoud print token like this in your debug console, this  is unique to each devices
    });

    // when app is in foreground
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
      }


      LocalNotificationService.displayFcm
        (notification: message.notification!,buildContext: context);
    });
    //when the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var product = context.watch<ProductViewModel>().products;
    return Consumer<ProductViewModel>(
      builder: (context, productVM, child) {
        return Scaffold(
          body: StreamBuilder(
              stream: productVM.products,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasError) return Text("Error");
                return ListView(
                  children: [
                    ElevatedButton(onPressed: (){
                      LocalNotificationService
                          .display("Notification Title",
                            "Notification Body", "Payload");
                    },child: Text("Notification Demo")),
                    ...snapshot.data.docs.map((document)
                        {
                          ProductModel product =
                            document.data();
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
    );
  }
}
