import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class UploadData {
  Future uploadToDatabase(File? file) async {
    final fileName = basename(file?.path??'');
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirectory = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirectory.child(fileName);
    try {
      await referenceImageToUpload.putFile(File(file?.path??''));
    } catch (e) {
      log(e.toString());
    }
  }
}
