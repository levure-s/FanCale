import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileModel extends ChangeNotifier {
  EditProfileModel(this.name, this.description) {
    nameController.text = name;
    descriptionController.text = description;
  }
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  String name;
  String description;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    this.description = description;
    notifyListeners();
  }

  bool isUpdated() {
    return name != null || description != null;
  }

  Future update() async {
    name = nameController.text;
    description = descriptionController.text;

    final uid = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .update({'name': name, 'description': description});
  }
}
