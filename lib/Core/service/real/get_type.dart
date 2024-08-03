import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/bookmodel_maya.dart';
import 'package:userboffee/Core/Models/detial_model.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class BookService {
  Dio dio = Dio();

  getType(String id) {
    dio.get("${BaseUrl}books/type/${id}");
  }

  late Response response;
  Future<List<DetailModel>> getAllBook(String id);
  Future<BookModel> getOneBook();
  createBook(BookModel);
  DeleteBook(num id);
}

class ServiceImmpl extends BookService {
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
  Future<List<DetailModel>> getAllBook(String id) async {
    try {
      response = await dio.get('${BaseUrl}books/type/${id}');
      print(response);
      if (response.statusCode == 200) {
        List<DetailModel> book_model = List.generate(
            response.data['data'].length,
            (index) => DetailModel.fromMap(response.data['data'][index]));
        print(response);
        return book_model;
      } else {
        print("no response in get allbook maya");
        return [];
      }
    } catch (e) {
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
