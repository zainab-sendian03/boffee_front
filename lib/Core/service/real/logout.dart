import 'package:dio/dio.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

Dio dio=Dio();
Future<bool> logout() async {
  Response response = await dio.post("${BaseUrl}logout",options: Options(headers: getoptions()));

  try {
    print("try in logout");
    if (response.statusCode == 200) {
      print("200 in logout");
      return true;
    } else {
      print("else in logout");
      print("");
      return false;
    }
  } catch (e) {
    print("Exception in logout" + e.toString());
    return false;
  }
}
