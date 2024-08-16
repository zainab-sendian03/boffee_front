import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/reviwe.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class Comments {
  Dio dio = Dio();
  String baseUrl = 'http://$ip_Zainab:8000/api/showAllReviwes';
  late Response response;
  Future<List<ReviweModel>> getAllComment();
}

class CommentService extends Comments {
  @override
  Future<List<ReviweModel>> getAllComment() async {
    try {
      response = await dio.get(baseUrl);
      if (response.statusCode == 200) {
        List<ReviweModel> comment2 = List.generate(response.data['data'].length,
            (index) => ReviweModel.fromMap(response.data['data'][index]));
        print(response.data);
        return comment2;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
