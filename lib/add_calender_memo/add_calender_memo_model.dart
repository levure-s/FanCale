import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddClenderMemoModel extends ChangeNotifier {
  Future addMemo(selectedDay, text) async {
    if (selectedDay == null) {
      throw '日付を選択してください';
    }
    if (text == null || text == '') {
      throw 'メモを入力してください';
    }
    await FirebaseFirestore.instance
        .collection('calendar')
        .add({'date': Timestamp.fromDate(selectedDay!), 'memo': text});
    notifyListeners();
  }
}
