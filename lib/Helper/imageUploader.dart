import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageUpload {
  static Future<String> uploadImage(
      {@required String fileName, @required File image}) async {
    String uploadUrl;

    StorageReference reference =
        FirebaseStorage.instance.ref().child("DummyTest").child(fileName);
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot;

    // Release the image data

    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    if (snapshot.error == null) {
      storageTaskSnapshot = snapshot;
      final String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      uploadUrl = downloadUrl;

      print('Upload success');
    } else {
      print('Error from image repo ${snapshot.error.toString()}');
      throw ('This file is not an image');
    }
    print('hi from imgeuploader');
    return uploadUrl;
  }
}
