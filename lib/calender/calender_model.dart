import 'package:cloud_firestore/cloud_firestore.dart';
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

      _filterDovuments();
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

    _filterDovuments();
  }

  void _filterDovuments() {
    if (documents == null) {
      return notifyListeners();
    }
    final List<QueryDocumentSnapshot> filtered = documents!.where((doc) {
      final date = (doc['date'] as Timestamp).toDate();
      return isSameDay(selectedDay, date);
    }).toList();

    filteredDocuments = filtered;
    notifyListeners();
  }
}