import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
late SharedPreferences pref;



 String accestoken2="1|vvr1jtvKtKGp3651AToTZleiVKM6uJzHHeTSBufv";
getoptions() {
 
String accestoken=  pref.getString("token") ??"";
  print(accestoken.toString());
    return {
      "Accept": "application/json",
      "Authorization": "Bearer $accestoken",
      // "Language_Code":
      //     getIt.get<SharedPreferences>().getString("lan")
      // ! Must Be From SharedPrefeneces
     
    }; 
}

getoptions2() {
 
String accestoken=  pref.getString("token") ??"";
  print(accestoken.toString());
    return {
      "accept": "application/json",
      "authorization": "Bearer $accestoken",
      // "Language_Code":
      //     getIt.get<SharedPreferences>().getString("lan")
      // ! Must Be From SharedPrefeneces
     
    }; 
}


GetIt getIt = GetIt.instance;
// GetIt getPref=GetIt.instance;

Setup() async {
  getIt.registerSingleton<SharedPreferences>(
      await SharedPreferences.getInstance());
pref =  await SharedPreferences.getInstance();
}
//String accesToken = getit.get<SharedPreferences>().getString('token') ?? '';
