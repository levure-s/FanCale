import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calender extends ChangeNotifier {
  final Stream<QuerySnapshot> _snapshots =
      FirebaseFirestore.instance.collection('calendar').snapshots();

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  List<QueryDocumentSnapshot>? documents;
  List<QueryDocumentSnapshot>? filteredDocuments;

  void fetchCalender() {
    _snapshots.listen((QuerySnapshot snapshot) {
      final List<QueryDocumentSnapshot> docs = snapshot.docs;
      documents = docs;

      _filterDocuments();
    });
  }

  void changeFormat(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      notifyListeners();
    }
  }

  void changedDay(selected, focused) {
    focusedDay = focused;
    selectedDay = selected;

    _filterDocuments();
  }

  void changePage(focused) {
    if (focusedDay != focused) {
      focusedDay = focused;
      notifyListeners();
    }
  }

  void _filterDocuments() {
    if (documents == null) {
      return notifyListeners();
    }
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    final List<QueryDocumentSnapshot> filtered = documents!.where((doc) {
      final date = (doc['date'] as Timestamp).toDate();
      final uid = doc['uid'];
      return isSameDay(selectedDay, date) && currentUid == uid;
    }).toList();
    filtered.sort((a, b) => a['date'].compareTo(b['date']));

    filteredDocuments = filtered;
    notifyListeners();
  }
}
