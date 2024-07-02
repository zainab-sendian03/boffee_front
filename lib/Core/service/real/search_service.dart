import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/bookmodel_maya.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class Search {
  Dio dio = Dio();

  // getType(String name) {
    String baseurl = "${BaseUrl}author";
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
      response = await dio.post('${BaseUrl}author',
          data: {'name': name});
      if (response.statusCode == 200) {
        List<BookModel> book_model = List.generate(response.data['data'].length,
            (index) => BookModel.fromMap(response.data['data'][index]));
        print(response);
        return book_model;
      } else {
        return [];
      }
    }on DioException catch (e) {
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
