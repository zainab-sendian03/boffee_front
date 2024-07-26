import 'package:dio/dio.dart';
import 'package:flutter_application_test/core/Models/reading_model.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';
import 'package:flutter_application_test/main.dart';

abstract class ReadingService {
  Dio dio = Dio();

  String baseurl = "http://$ip_Zainab:8000/api/myShelf";

  late Response response;
  Future<List<ReadingModel>> getAllBook(String key);
  Future<ReadingModel> getOneBook();
  createBook(ReadingModel);
  DeleteBook(num id);
}

class ServeShelf extends ReadingService {
  @override
  DeleteBook(num id) {
    // TODO: implement DeleteBook
    throw UnimplementedError();
  }

  @override
  createBook(ReadingModel) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  Future<List<ReadingModel>> getAllBook(String key) async {
    try {
      response = await dio.post(baseurl,
          data: {'status': 'reading'},
          options: Options(headers: {"Authorization": "Bearer $token"}));
      if (response.statusCode == 200) {
        List<ReadingModel> reading = List.generate(response.data.length,
            (index) => ReadingModel.fromMap(response.data[index]));
        print(response);
        return reading;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(e);
      return [];
    }
  }


  @override
  Future<ReadingModel> getOneBook() {
    // TODO: implement getOneBook
    throw UnimplementedError();
  }
}
