import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
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

  Future signUp() async {
    email = titleController.text;
    password = autherController.text;

    if (email == null || password == null) {
      return;
    }

    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
    final user = userCredential.user;

    if (user == null) {
      return;
    }

    final uid = user.uid;
    final doc = FirebaseFirestore.instance.collection('users').doc(uid);
    await doc.set({'uid': uid, 'email': email});
  }
}
