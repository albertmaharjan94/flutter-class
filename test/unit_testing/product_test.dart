
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:first_app_a/repositories/product_repository.dart';
import 'package:first_app_a/services/firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  FirebaseService.db = FakeFirebaseFirestore();
  final ProductRepository productRepository = ProductRepository();

  test("Create a product", () async {
    var response = await productRepository
        .addProduct(
          ProductModel(
              productName: "Test Name",
              productPrice: "Test Price",
              imageUrl: "Test Url",
              imagePath: "Test Path"
          )
        );
    expect(response, false);
  });

  test("Get product snapshot", () async{
    var data = productRepository.getData();
    expect(data.runtimeType, Stream<QuerySnapshot<ProductModel>>);
  });
}