import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences pref;
getoptions() {
 
  
    return {
      "Accept": "application/json",
      "Authorization": "Bearer 1|HGaru12dgBWBICyer8d06yjv9jATrKQvXts8n55V",
      "Language_Code":
          getIt.get<SharedPreferences>().getString("lan")
      // ! Must Be From SharedPrefeneces
    }; 
}

GetIt getIt = GetIt.instance;
Setup() async {
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
pref = await SharedPreferences.getInstance();
}