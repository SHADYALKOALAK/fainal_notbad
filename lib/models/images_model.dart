class ImagesModel {
  String? path;
  String? link;

  ImagesModel({
    this.path,
    this.link,
  });

  ImagesModel.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['link'] = link;
    json['path'] = path;
    return json;
  }
}
