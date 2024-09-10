import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/reading_model.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class ReadingService {
  Dio dio = Dio();
  String baseurl = "${BaseUrl}myShelf";
  late Response response;

  Future<List<ReadingModel>> getAllBook(String status);
  Future<ReadingModel?> getOneBook(int id);
  Future<void> createBook(ReadingModel book);
  Future<void> deleteBook(num id);
}

class ServeShelf extends ReadingService {
  @override
  Future<List<ReadingModel>> getAllBook(String status) async {
    try {
      response = await dio.post(
        baseurl,
        data: {'status': status},
        options: Options(headers: getoptions2()),
      );

      print("Response data: ${response.data}");

      if (response.statusCode == 200 && response.data != null) {
        // Check if 'shelves' exists and is a list
        if (response.data.containsKey('shelves') &&
            response.data['shelves'] is List) {
          List<dynamic> shelvesList = response.data['shelves'];

          List<ReadingModel> reading = shelvesList.map((shelfItem) {
            return ReadingModel.fromMap(shelfItem);
          }).toList();

          return reading;
        } else {
          print("Response format is unexpected or 'shelves' key is missing.");
          return [];
        }
      } else {
        print("Failed to fetch books: ${response.statusMessage}");
        return [];
      }
    } on DioError catch (e) {
      print("Error fetching books: $e");
      return [];
    }
  }

  Future<void> updateBookStatus(int id, String newStatus) async {
    try {
      response = await dio.put(
        "$baseurl/$id",
        data: {'status': newStatus},
        options: Options(headers: getoptions2()),
      );

      if (response.statusCode == 200) {
        print("Book status updated successfully");
      } else {
        print("Failed to update book status: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      print("Error updating book status: $e");
    }
  }

  @override
  Future<void> deleteBook(num id) async {
    try {
      response = await dio.delete(
        "$baseurl/$id",
        options: Options(headers: getoptions2()),
      );
      if (response.statusCode == 200) {
        print("Book deleted successfully");
      } else {
        print("Failed to delete book: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      print("Error deleting book: $e");
    }
  }

  @override
  Future<void> createBook(ReadingModel book) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  Future<ReadingModel?> getOneBook(int id) {
    // TODO: implement getOneBook
    throw UnimplementedError();
  }
}
