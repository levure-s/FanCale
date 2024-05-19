import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancale/calender/model/graphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Graphics extends ChangeNotifier {
  Graphics({required this.currentMonth});

  List<QueryDocumentSnapshot>? documents;
  int currentMonth;
  Graphic? currentGraphic;

  void fetchGraphics() {
    final bool isEmpty = FirebaseAuth.instance.currentUser == null;
    if (isEmpty) {
      return;
    }
    final Stream<QuerySnapshot> snapshots =
        FirebaseFirestore.instance.collection('graphics').snapshots();
    snapshots.listen((QuerySnapshot snapshot) {
      final List<QueryDocumentSnapshot> docs = snapshot.docs;
      documents = docs;
      _filtereDocuments();
    });
  }

  void readyForLogout() {
    documents = null;
    notifyListeners();
  }

  void changeCurrentMonth(int month) {
    if (currentMonth != month) {
      currentMonth = month;
      _filtereDocuments();
    }
  }

  void _filtereDocuments() {
    print('filter');
    if (documents == null) {
      print('null');
      return notifyListeners();
    }
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    final List<QueryDocumentSnapshot> filtered = documents!.where((doc) {
      final month = doc['month'];
      final uid = doc['uid'];
      return currentMonth == month && currentUid == uid;
    }).toList();
    if (filtered.isEmpty) {
      currentGraphic = null;
      print('empty');
      return notifyListeners();
    }
    currentGraphic = Graphic(
        id: filtered.first.id,
        imgURL: filtered.first['imgURL'],
        month: currentMonth);
    print(currentGraphic);
    notifyListeners();
  }
}
