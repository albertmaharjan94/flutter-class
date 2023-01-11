import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:first_app_a/repositories/product_repository.dart';
import 'package:first_app_a/screens/widgets/make_rs_text.dart';
import 'package:first_app_a/services/notification_service.dart';
import 'package:first_app_a/viewmodels/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class FireDatabaseScreen extends StatefulWidget {
  const FireDatabaseScreen({Key? key}) : super(key: key);
  @override
  State<FireDatabaseScreen> createState() => _FireDatabasescreenstate();
}
class _FireDatabasescreenstate extends State<FireDatabaseScreen> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  void deleteTask(String id) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Are you sure you want to delete"),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseFirestore db = FirebaseFirestore.instance;
              _productViewModel.deleteProduct(id)
              .then((value)=>
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content:Text("Product deleted"))
              ));
              Navigator.of(context).pop();
            },
            child: Text("Delete"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  void deleteProduct(String? id) async{

  }

  // ProductRepository _productRepository = ProductRepository();
  late ProductViewModel _productViewModel;
  @override
  void initState() {
    _productViewModel = Provider.of<ProductViewModel>
      (context,listen: false);
    _productViewModel.getProducts();

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

      NotificationService.displayFcm(notification: message.notification!,buildContext: context);
    });
    //when the app is in background but opened and user taps
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var products = context.watch<ProductViewModel>().products;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            NotificationService.display("This is title",
                "THis is body", "/add-product", context);
          }, icon: Icon(Icons.notification_important))
        ],
      ),
      body: StreamBuilder(
        stream: products,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<ProductModel>> snapshot) {
          if(snapshot.hasError) return Text("Error");
          return ListView(
            children: [
              MakeRsText(price: "100"),
              ...snapshot.data!.docs.map((document) {
                ProductModel product = document.data();
                return ListTile(
                  title: Text(
                    product.productName,
                    style: TextStyle(fontSize: 40),
                  ),
                  trailing: Wrap(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(
                              '/edit_product', arguments: document.id);
                        },
                        child: Icon(Icons.edit),
                      ),
                      InkWell(
                        onTap: () {
                          deleteProduct(document.id);
                        },
                        child: Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        }
      ),



      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pushNamed("/add-product");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
