import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddCalenderGraphicsModel extends ChangeNotifier {
  File? imageFile;
  bool isLoading = false;
  final picker = ImagePicker();
  double imageAlignmentX = 0.0;
  double imageAlignmentY = 0.0;

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  void updateAlignmentX(double value) {
    imageAlignmentX = value;
    notifyListeners();
  }

  void updateAlignmentY(double value) {
    imageAlignmentY = value;
    notifyListeners();
  }

  Future pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future saveImage(int month) async {
    String? imgURL;
    if (imageFile == null) {
      throw '画像が選択されていません';
    }
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final doc = FirebaseFirestore.instance.collection('graphics').doc();
    final task = await FirebaseStorage.instance
        .ref('graphics/${doc.id}')
        .putFile(imageFile!);
    imgURL = await task.ref.getDownloadURL();
    await doc.set({
      'imgURL': imgURL,
      'uid': uid,
      'month': month,
      'alignmentX': imageAlignmentX,
      'alignmentY': imageAlignmentY,
    });
  }
}
