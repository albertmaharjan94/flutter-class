import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';
import '../services/firebase_service.dart';

class ProductRepository{
  CollectionReference<ProductModel> ref = FirebaseService.db.collection("products")
      .withConverter<ProductModel>(
    fromFirestore: (snapshot, _) {
      return ProductModel.fromFirebaseSnapshot(snapshot);
    },
    toFirestore: (model, _) => model.toJson(),
  );

  Stream<QuerySnapshot<ProductModel>> getData()  {
    Stream<QuerySnapshot<ProductModel>> response = ref
        .snapshots();
    return response;
  }

  Future<ProductModel?> getOneData(String id) async {
    DocumentSnapshot<ProductModel> response = await ref.doc(id).get();
    return response.data();
  }
 //create delete function(Classwork)
Future<void>deleteProduct(String id)async{
    await ref.doc(id).delete();
  }

//create add function
Future<void>addProduct(ProductModel data) async {
  await ref.add(data);
  }
}