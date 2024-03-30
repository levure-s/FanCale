import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCalenderGraphicsModel extends ChangeNotifier {
  File? imageFile;
  bool isLoading = false;
  final picker = ImagePicker();

  void startLoading() {
    isLoading = true;
    notifyListeners();
  }

  void endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future pickImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      notifyListeners();
    }
  }

  Future saveImage() async {
    String? imgURL;
    if (imageFile == null) {
      return;
    }

    final doc = FirebaseFirestore.instance.collection('graphics').doc();
    final task = await FirebaseStorage.instance
        .ref('graphics/${doc.id}')
        .putFile(imageFile!);
    imgURL = await task.ref.getDownloadURL();
    await doc.set({'imgURL': imgURL});
  }
}
