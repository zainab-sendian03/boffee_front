import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/colors.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkmode = false;
  ThemeData themedata = ThemeData();
  // late bool is_startcolor;
  Color newcolor = Light_Brown;
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

  void changecolor(Color newcolor1) {
    newcolor = newcolor1;
    // is_startcolor = !is_startcolor;
    //getIt.get<SharedPreferences>().setBool
    notifyListeners();
  }

  void IniColortheme() {
    // is_startcolor = getIt.get<SharedPreferences>().getBool("themecolor") ?? false;
    // if (is_startcolor) {
    newcolor = Light_Brown;
    // } else {
    //   //! i do not know how to say when you press in this button

    // }
  }
}
