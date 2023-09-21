import 'dart:io';
import 'package:fainalnotbad/models/images_model.dart';
import 'package:firebase_storage/firebase_storage.dart';



class FbStorageController {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<ImagesModel?> uploadFile(File file, {required String path}) async {
    var data = await storage
        .ref()
        .child('$path/${DateTime.now().toString()}')
        .putFile(file);
    var link = await data.ref.getDownloadURL();
    var fullPth = data.ref.fullPath;
    //
    return ImagesModel(path: fullPth, link: link);
  }



  Future<void> delete(String path) async {
    await storage.ref().child(path).delete();
  }
}
