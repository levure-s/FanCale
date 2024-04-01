import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Graphics extends ChangeNotifier {
  final Stream<QuerySnapshot> _snapshots =
      FirebaseFirestore.instance.collection('graphics').snapshots();

  List<QueryDocumentSnapshot>? documents;
  String graphicURL = '';

  void fetchGraphics() {
    _snapshots.listen((QuerySnapshot snapshot) {
      final List<QueryDocumentSnapshot> docs = snapshot.docs;
      documents = docs;
      if (documents == null) {
        return notifyListeners();
      }
      graphicURL = documents!.first['imgURL'];
      notifyListeners();
    });
  }
}
