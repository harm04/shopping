import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  
  Future<List<String>> uploadMultipleImagesToStorage(
      String childName, List<Uint8List> files) async {
    List<String> downloadUrls = [];

    try {
      for (int i = 0; i < files.length; i++) {
        Reference ref = _storage
            .ref()
            .child(childName)
            .child(_auth.currentUser!.uid)
            .child('image_$i.jpg');

        UploadTask uploadTask = ref.putData(files[i]);
        TaskSnapshot snap = await uploadTask;
        String downloadUrl = await snap.ref.getDownloadURL();
        downloadUrls.add(downloadUrl);
      }
    } catch (e) {
      print("Error uploading images: $e");
    }

    return downloadUrls;
  }
}
