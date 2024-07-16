
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userboffee/Core/Models/reading_model.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/feature/getbooks/ser_get_books.dart';

abstract class ReadingService {
  Dio dio = Dio();
 
String baseurl = "${BaseUrl}myShelf";

 late Response response;
 Future<List <ReadingModel>>getAllBook(String key);
  Future<ReadingModel> getOneBook();
  createBook(ReadingModel);
  DeleteBook(num id);
}
class ServeShelf extends ReadingService{
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
String token = "2|tsg3dDjTs2dtdSG38UXbqYiPmKw9jquPmn9V7fwX";

  @override
  Future<List<ReadingModel>> getAllBook(String key)async {
    try {
      response=await dio.post(baseurl,
      data: {
        'status':'reading'
      },
      options: Options(
        headers: {
          "Authorization":"Bearer $token",
            "Language_Code":
          getIt.get<SharedPreferences>().getString("lan")
        }
      )
      );
      if(response.statusCode==200){
        List<ReadingModel> reading =List.generate(response.data.length, (index) => ReadingModel.fromMap(response.data[index]));
        print(response);
    return reading ;
      }else{
        return [];
      }
    }on DioException catch (e) {
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

