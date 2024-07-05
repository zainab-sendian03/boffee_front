import 'package:dio/dio.dart';
import 'package:flutter_application_test/core/Models/basic_model.dart';
import 'package:flutter_application_test/core/Models/book_model.dart';
import 'package:flutter_application_test/core/config/options.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';

String BaseUrl = "http://$ip_Zainab:8000/api/";
Dio dio = Dio();
Future<ResultModel> getBooks() async {
  Response response =
      await dio.get("${BaseUrl}books", options: Options(headers: getoptions()));
  try {
    if (response.statusCode == 200) {
      print("200 in ser books");
      List<BookModel> booklist = List.generate(
          response.data["data"]["books"].length,
          (index) => BookModel.fromMap(response.data["data"]["books"][index]));
      return ListOfbook<BookModel>(result: booklist as List<BookModel>);
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
