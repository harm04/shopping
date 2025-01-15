import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
