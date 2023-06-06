import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference<Map<String,dynamic>> userCollection = FirebaseFirestore.instance.collection("users");