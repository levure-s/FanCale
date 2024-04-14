import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Graphics extends ChangeNotifier {
  Graphics({required this.month});
  final Stream<QuerySnapshot> _snapshots =
      FirebaseFirestore.instance.collection('graphics').snapshots();

  List<QueryDocumentSnapshot>? documents;
  List<QueryDocumentSnapshot>? filteredDocuments;
  String graphicURL = '';
  int month;

  void fetchGraphics() {
    _snapshots.listen((QuerySnapshot snapshot) {
      documents = snapshot.docs;

      if (documents == null) {
        return notifyListeners();
      }
      final currentUid = FirebaseAuth.instance.currentUser?.uid;
      final List<QueryDocumentSnapshot> filtered = documents!.where((doc) {
        final uid = doc['uid'];
        final m = doc['month'];
        return currentUid == uid && month == m;
      }).toList();
      graphicURL = filtered.first['imgURL'];
      notifyListeners();
    });
  }
}
