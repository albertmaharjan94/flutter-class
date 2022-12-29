import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService{
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();
}