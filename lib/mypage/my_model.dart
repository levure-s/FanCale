import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyModel extends ChangeNotifier {
  String? email;

  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void feachUser() {
    final user = FirebaseAuth.instance.currentUser;
    email = user?.email;
    notifyListeners();
  }

  Future logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
