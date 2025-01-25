import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<List<String>> pickImages() async {
  List<String> images = [];
  try {
    var files = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: FileType.image);
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(files.files[i].path!);  // Store file path as String
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}

Future<File?> pickImage() async {
  final ImagePicker picker = ImagePicker();
  final imageFile = await picker.pickImage(source: ImageSource.gallery);
  if (imageFile != null) {
    return File(imageFile.path);
  }
  return null;
}