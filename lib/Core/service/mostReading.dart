import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/book_model.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

Future<ResultModel> mostreading() async {
  Dio dio = Dio();
  Response response = await dio.get(BaseUrl+"mostReading");
  try {
    if (response.statusCode == 200) {
      List<Bookmodel> most_reading_List = List.generate(
          response.data["data"].length,
          (index) => Bookmodel.fromMap(response.data["data"][index]));
      return ListofEverything(listresult: most_reading_List);
    } else {
      return ErrorModel();
    }
  } catch (e) {
    return ExceptionModel();
  }
}
