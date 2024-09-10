import 'package:dio/dio.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

class ReadLaterService {
  Future<bool> addToReadLater(int bookId) async {
    try {
      final String url = "http://$ip_Zainab:8000/api/shelf/later";
      var headers = getoptions();
      var response = await Dio().post(url,
          options: Options(headers: headers), data: {'book_id': bookId});
      print("^^^^^^^^^^^^^^$response");
      if (response.statusCode == 200) {
        print("Book successfully added to Read Later");
        return true;
      } else {
        print("Failed to add book to Read Later");
        return false;
      }
    } catch (e) {
      print("Error occurred while adding to Read Later: $e");
      return false;
    }
  }
}
