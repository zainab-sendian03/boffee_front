import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/config/options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  late bool isDarkmode;
  late ThemeData themedata;
  void changeTheme() {
    if (isDarkmode) {
      themedata = ThemeData.light();
    } else {
      themedata = ThemeData.dark();
    }
    isDarkmode = !isDarkmode;
    getIt.get<SharedPreferences>().setBool("theme", isDarkmode);
    notifyListeners();
  }

  void initTheme() {
    isDarkmode = getIt.get<SharedPreferences>().getBool("theme") ?? false;
    if (isDarkmode) {
      themedata = ThemeData.dark();
    } else {
      themedata = ThemeData.light();
    }
  }
}
