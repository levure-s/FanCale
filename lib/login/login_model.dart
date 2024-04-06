import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final autherController = TextEditingController();

  String? email;
  String? password;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPaaword(String password) {
    this.password = password;
    notifyListeners();
  }

  Future login() async {
    email = titleController.text;
    password = autherController.text;

    if (email == null || password == null) {
      return;
    }

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
