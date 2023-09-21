import 'package:fainalnotbad/models/images_model.dart';

class TaskModel {
  String? id;
  String? title;
  String? not;
  List<dynamic>? images;

  TaskModel({
    this.id,
    this.title,
    this.not,
    this.images,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['titel'];
    not = json['not'];
    images = (json['images']).map((e) => ImagesModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id'] = id;
    json['titel'] = title;
    json['not'] = not;
    json['images'] = images!.map((e) => e.toJson()).toList();
    return json;
  }
}
