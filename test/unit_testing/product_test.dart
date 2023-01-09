import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:first_app_a/models/product_model.dart';
import 'package:first_app_a/repositories/product_repository.dart';
import 'package:first_app_a/services/firebase_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  FirebaseService.db = FakeFirebaseFirestore();
  ProductRepository _productRepository = ProductRepository();
  test("Test adding product", () async {
    var result = await _productRepository.addProduct(
      ProductModel(
          productName: "Test Name",
          productPrice: "100",
          imageUrl: "imageUrl",
          imagePath: "imagePath")
    );

    expect(result, true);

  });

}