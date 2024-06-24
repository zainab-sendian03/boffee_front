import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

getoptions() {
  return {
    "Accept": "application/json",
    "Authorization": "Bearer 1|qir6q0BVfUz0LYXkN4gV8YUxaWnbAyihtiEWMro1"
  };
}
GetIt getIt=GetIt.instance;
Setup()async{
  getIt.registerSingleton<SharedPreferences>(
   await SharedPreferences.getInstance()
  );
}