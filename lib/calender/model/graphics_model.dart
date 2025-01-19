import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancale/calender/model/graphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Graphics extends ChangeNotifier {
  Graphics({required this.currentMonth});
  final Stream<QuerySnapshot> _snapshots =
      FirebaseFirestore.instance.collection('graphics').snapshots();

  List<QueryDocumentSnapshot>? documents;
  int currentMonth;
  Graphic? currentGraphic;

  void fetchGraphics() {
    _snapshots.listen((QuerySnapshot snapshot) {
      final List<QueryDocumentSnapshot> docs = snapshot.docs;
      documents = docs;
      _filtereDocuments();
    });
  }

  void changeCurrentMonth(int month) {
    if (currentMonth != month) {
      currentMonth = month;
      _filtereDocuments();
    }
  }

  void _filtereDocuments() {
    if (documents == null) {
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
      return notifyListeners();
    }
    final doc = filtered.first.data() as Map<String, dynamic>;
    final alignmentX = doc.containsKey('alignmentX') ? doc['alignmentX'] : 0.0;
    final alignmentY = doc.containsKey('alignmentY') ? doc['alignmentY'] : 0.0;
    currentGraphic = Graphic(
      id: filtered.first.id,
      imgURL: filtered.first['imgURL'],
      month: currentMonth,
      alignmentX: alignmentX,
      alignmentY: alignmentY,
    );
    notifyListeners();
  }
}
