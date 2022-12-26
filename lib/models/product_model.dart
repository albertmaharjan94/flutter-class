// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.productName,
    required this.productPrice,
    required this.imageUrl,
    required this.imagePath,
  });

  String productName;
  String productPrice;
  String imageUrl;
  String imagePath;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    productName: json["productName"],
    productPrice: json["productPrice"],
    imageUrl: json["imageUrl"],
    imagePath: json["imagePath"],
  );

  Map<String, dynamic> toJson() => {
    "productName": productName,
    "productPrice": productPrice,
    "imageUrl": imageUrl,
    "imagePath": imagePath,
  };
}
