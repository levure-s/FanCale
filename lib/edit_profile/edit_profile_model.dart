import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfileModel extends ChangeNotifier {
  EditProfileModel(this.currentName, this.currentDescription) {
    nameController.text = currentName;
    descriptionController.text = currentDescription;
  }
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final String currentName;
  final String currentDescription;

  String? name;
  String? description;
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
