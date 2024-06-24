import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/config/options.dart';
 
String BaseUrl = "http://localhost:8000/api/";
 Dio dio = Dio();
Future<ResultModel> getPosts() async {

  Response response = await dio.get("${BaseUrl}showAllPosts",options: Options(headers: {"Accept":"application/json"}));
  try {
    if (response.statusCode == 200) {
      print("200 in ser getPosts");
      List postslist = List.generate(response.data.length,
          (index) => PostModel.fromMap(response.data["data"][index]));
      return ListOf(result: postslist);
    } else {
      print("Error in get posts");
      return ErrorModel();
    }
  } on DioException catch (e) {
    print("Exception in get posts");
    print(e.toString());
    return ExceptionModel();
  }
}
 Future<ResultModel> createPostser(PostModel post)async{
Response response=await dio.post("${BaseUrl}createPost",
options: Options(headers: getoptions()),
data: post.toMap()

);
try{
  if (response.statusCode==200) {
    print("200 and data has sended");
return successModel();
    
  } else {
     print(" ops error in createPost  ");
     return ErrorModel();
  }
}
catch(e){
    print(" ops exception in createPost  ");
    return ExceptionModel();
}

}