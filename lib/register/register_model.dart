import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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

  String convertErrorMessage(String msg) {
    if (msg.contains('[firebase_auth/invalid-email]')) {
      return 'メールアドレスを正しい形式で入力してください';
    }
    if (msg.contains('[firebase_auth/email-already-in-use]')) {
      return '登録済みのメールアドレスです';
    }
    if (msg.contains('[firebase_auth/weak-password]')) {
      return 'パスワードは6文字以上入力してください';
    }
    return msg;
  }

  Future signUp() async {
    email = emailController.text;
    password = passwordController.text;

    if (email == null || email == '') {
      throw ('メールアドレスを入力してください');
    }
    if (password == null || password == '') {
      throw ('パスワードを入力してください');
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
