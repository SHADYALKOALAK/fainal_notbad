import 'package:fainalnotbad/models/images_model.dart';

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? password;
  String? fcm;
  ImagesModel? image;
  String? permission;

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.password,
    this.fcm,
    this.image,
    this.permission,
  });

  UserModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    fcm = json['fcm'];
    permission = json['permission'];
    image = json['image'] != null ? ImagesModel.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['fullName'] = fullName;
    json['email'] = email;
    json['password'] = password;
    json['fcm'] = fcm;
    json['permission'] = permission;
    json['image'] = image != null ? image!.toJson() : null;
    return json;
  }
}
