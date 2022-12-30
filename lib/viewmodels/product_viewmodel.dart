import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app_a/repositories/product_repository.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class ProductViewModel with ChangeNotifier{
  Stream<QuerySnapshot<ProductModel>>? _products;
  Stream<QuerySnapshot<ProductModel>>? get products => _products;

  ProductRepository _productRepository = ProductRepository();

  Future<void> productData() async {
    _products = _productRepository.getAllData();
    notifyListeners();
  }

}