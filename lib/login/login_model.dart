import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
