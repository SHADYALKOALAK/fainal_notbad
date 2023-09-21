import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

mixin CacheNetWorkImageHelper {
  CachedNetworkImage cacheImage(String link) {
    return CachedNetworkImage(imageUrl: link, fit: BoxFit.cover);
  }
}
