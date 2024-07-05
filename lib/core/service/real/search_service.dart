import 'package:dio/dio.dart';
import 'package:flutter_application_test/core/Models/book_model.dart';
import 'package:flutter_application_test/core/constants/linksapi.dart';

abstract class Search {
  Dio dio = Dio();

  // getType(String name) {
  String baseurl = "http://$ip_Zainab:8000/api/author";
  // }

  late Response response;
  Future<List<BookModel>> PostAllBook(String name);
  Future<BookModel> getOneBook();
  createBook(BookModel);
  DeleteBook(num id);
}

class Servicesearch extends Search {
  @override
  DeleteBook(num id) {
    // TODO: implement DeleteBook
    throw UnimplementedError();
  }

  @override
  createBook(BookModel) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  Future<List<BookModel>> PostAllBook(String name) async {
    try {
      response = await dio
          .post('http://$ip_Zainab:8000/api/author', data: {'name': name});
      if (response.statusCode == 200) {
        List<BookModel> book_model = List.generate(response.data['data'].length,
            (index) => BookModel.fromMap(response.data['data'][index]));
        print(response);
        return book_model;
      } else {
        return [];
      }
    } on DioException catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<BookModel> getOneBook() {
    // TODO: implement getOneBook
    throw UnimplementedError();
  }
}
