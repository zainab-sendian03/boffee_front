import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/reviwe.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class Reviwe {
  Dio dio = Dio();

  // getType(String name) {
  String baseurl = "$BaseUrl+addReviwe";
  // }

  late Response response;
  Future<ResultModel> PostAllReviwes(int book_id, String body);
  Future<ReviweModel> postOneReviwe();
  createReviwe();
  DeleteReviwe(num id);
}

class ReiweService extends Reviwe {
  @override
  DeleteReviwe(num id) {
    // TODO: implement DeleteReviwe
    throw UnimplementedError();
  }

  @override
  Future<ResultModel> PostAllReviwes(int book_id, String body) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer 6|OPB6wdez9TU7CKHPoPEpQO1CTkRVpiOcxHRVvLAx'
      };
      var data = FormData.fromMap({
        'body': body,
        'book_id': book_id,
      });

      var dio = Dio();
      var response = await dio.request(
        'http://$ip_Zainab:8000/api/addReviwe',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return successModel();
      } else {
        return ExceptionModel();
      }
    } on DioException catch (e) {
      print(e);
      return ExceptionModel();
    }
  }

  @override
  createReviwe() {
    // TODO: implement createReviwe
    throw UnimplementedError();
  }

  @override
  Future<ReviweModel> postOneReviwe() {
    // TODO: implement postOneReviwe
    throw UnimplementedError();
  }
}
