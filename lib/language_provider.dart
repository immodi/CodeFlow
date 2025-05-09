import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier {
  final Map<String, String> languages = {
    'en': 'English',
    'ar': 'العربية'
  };

  String lang = 'en';

  void setLanguage(String newLang) {
    if (lang != newLang) {
      lang = newLang;
      notifyListeners();
      print('Language changed to: $newLang'); // أضف هذا للتأكد

    }
  }
}