import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/Book_model.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

String BaseUrl = "http://$ip_Zainab:8000/api/";
Dio dio = Dio();
Future<ResultModel> getBooks() async {
  Response response =
      await dio.get("${BaseUrl}books", options: Options(headers: getoptions()));
  try {
    if (response.statusCode == 200) {
      print("200 in ser books");
      List<Bookmodel> booklist = List.generate(
          response.data["data"]["books"].length,
          (index) => Bookmodel.fromMap(response.data["data"]["books"][index]));
      return ListOfbook<Bookmodel>(result: booklist as List<Bookmodel>);
    } else {
      print("Error in get books");
      return ErrorModel();
    }
  } on DioException catch (e) {
    print("Exception in get books");
    print(e.toString());
    return ExceptionModel();
  }
}
