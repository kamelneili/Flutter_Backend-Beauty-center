import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  Future<void> uploadImage(XFile image) async {
    try {
      await storage
          .ref('product_images/${image.name}')
          .putFile(File(image.path));
      //  .then((p0) => DatabaseRepository().updateUserPictures(image.name));
    } catch (_) {}
  }

  Future<String> getDownloadUrl(String imageName) async {
    String downloadUrl =
        await storage.ref('product_images/$imageName').getDownloadURL();
    return downloadUrl;
  }
}
