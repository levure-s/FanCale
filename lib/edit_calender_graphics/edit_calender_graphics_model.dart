import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancale/calender/model/graphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCalenderGraphicsModel extends ChangeNotifier {
  EditCalenderGraphicsModel({required this.graphic})
      : imageAlignmentX = graphic.alignmentX, // graphicから初期化
        imageAlignmentY = graphic.alignmentY;
  final Graphic graphic;
  File? imageFile;
  bool isLoading = false;
  final picker = ImagePicker();
  double imageAlignmentX;
  double imageAlignmentY;

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

  Future saveImage() async {
    final uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    final doc =
        FirebaseFirestore.instance.collection('graphics').doc(graphic.id);
    final data = {
      'uid': uid,
      'alignmentX': imageAlignmentX,
      'alignmentY': imageAlignmentY,
    };
    if (imageFile != null) {
      final task = await FirebaseStorage.instance
          .ref('graphics/${doc.id}')
          .putFile(imageFile!);
      data['imgURL'] = await task.ref.getDownloadURL();
    }
    await doc.update(data);
  }
}
