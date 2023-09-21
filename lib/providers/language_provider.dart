import 'package:fainalnotbad/cache/cache_controller.dart';
import 'package:fainalnotbad/enums/enums.dart';
import 'package:flutter/foundation.dart';



class LanguageProvider extends ChangeNotifier {
  String language = CacheController().getter(CacheKeys.language) ?? 'ar';

  Future<void> changeLanguage() async {
    language = language == 'ar' ? 'en' : 'ar';
    await CacheController().setter(CacheKeys.language, language);
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    language = lang;
    await CacheController().setter(CacheKeys.language, lang);
    notifyListeners();
  }
}
