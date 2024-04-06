import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final autherController = TextEditingController();

  String? email;
  String? password;
  final picker = ImagePicker();

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
  }
}
