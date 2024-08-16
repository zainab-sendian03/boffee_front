import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/suggestionmodel.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class Suggestion{
   Dio dio = Dio();

  // getType(String name) {
    String baseurl = "$BaseUrl+createsuggestion";
  // }

  late Response response;
  Future<ResultModel> PostAllBook(String body,String author_name);
  Future<SuggestionModel> postOneBook();
  createBook(SuggestionModel);

}
class porpose extends Suggestion{

  @override
  Future<ResultModel> PostAllBook(String body, String author_name) async{
 try{
  // response =await dio.post('http://localhost:8000/api/createsuggestion',
  // data: {
  //   'body':body,
  //   'author_name':author_name
  // },options: Options(headers: getoptions2()));
  // if(response.statusCode == 200){
  
  // return successModel() ;
  // }else{return ErrorModel() ;}
  var headers = {
  'Accept': 'application/json',
  'Authorization': 'Bearer 7|70N0d3nx3tbKJtCUULa024lzzKIQHR4AlKkF3cll'
};
var data = FormData.fromMap({
  'body': 'body',
  'author_name': 'author_name',

}

);

var dio = Dio();
var response = await dio.request(
  'http://localhost:8000/api/createsuggestion',
  options: Options(
    method: 'POST',
    headers: headers,
  ),
  data: data,
);

if (response.statusCode == 200) {
  return successModel();
}
else {
  return ExceptionModel();
}
 }
 on DioException catch (e) {
      print(e);
      return ExceptionModel();
    }
  }

  @override
  createBook(SuggestionModel) {
    // TODO: implement createBook
    throw UnimplementedError();
  }

  @override
  Future<SuggestionModel> postOneBook() {
    // TODO: implement postOneBook
    throw UnimplementedError();
  }
}