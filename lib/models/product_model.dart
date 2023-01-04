import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.imagePath,
  });

  String productName;
  String? id;
  String productPrice;
  String imageUrl;
  String imagePath;

  factory ProductModel.fromFirebaseSnapshot(
      DocumentSnapshot<Map<String, dynamic>> json) => ProductModel(
    id: json.id,
    productName: json["productName"],
    productPrice: json["productPrice"],
    imageUrl: json["imageUrl"],
    imagePath: json["imagePath"],
  );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["productName"],
    productName: json["productName"],
    productPrice: json["productPrice"],
    imageUrl: json["imageUrl"],
    imagePath: json["imagePath"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "productName": productName,
    "productPrice": productPrice,
    "imageUrl": imageUrl,
    "imagePath": imagePath,
  };
}