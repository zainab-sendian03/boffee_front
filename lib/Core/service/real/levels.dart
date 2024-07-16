import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/levels/image_level.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/feature/getbooks/ser_get_books.dart';

Dio dio = Dio();
Future<ResultModel> getLevel() async {
  Response response =
      await dio.get("${BaseUrl}level", options: Options(headers: getoptions2()));
  try {
    if (response.statusCode == 200) {
      print(response.data.toString());
      print("200 in level service");
      // List<ResultModel> responselist = List.generate(
      //     response.data["data"].length,
      //     (index) =>
      //         ImageLevelModel(image:["image"][""] , ratio: [][])
      // );
              //.fromMap(response.data["data"][index]));
      //  ListofEverything(listresult: responselist);

      return ImageLevelModel(image: response.data["data"]["image"], ratio: response.data["data"]["ratio"]);
    } else {
      print("error in level service");
      return ErrorModel();
    }
  } catch (e) {
    print(e.toString());
    print("exception in level service");
    return ExceptionModel();
  }
}
