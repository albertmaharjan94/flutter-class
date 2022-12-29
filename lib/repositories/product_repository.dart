import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:first_app_a/services/firebase_service.dart';

class ProductRepository{
  CollectionReference<ProductModel> ref =
      FirebaseService.db.collection("products")
      .withConverter(
          fromFirestore: (snapshot, _)
          => ProductModel.fromFirebaseSnapshot(snapshot) ,
          toFirestore: (model, _)
          => model.toJson()
      );

  Future<ProductModel?> getData(String id) async {
    DocumentSnapshot<ProductModel> response =
    await ref.doc(id).get();
    return response.data();
  }

  Stream<QuerySnapshot<ProductModel>> getAllData(){
    Stream<QuerySnapshot<ProductModel>> response =
        ref.snapshots();
    return response;
  }
  // classwork
  Future<void> deleteProduct(String id) async{
    await ref.doc(id).delete();
  }
  Future<void> addProduct(ProductModel product) async {
    await ref.add(product);
  }
  Future<void> updateProduct
      (String id, ProductModel product) async {
    await ref.doc(id).set(product);
  }
}