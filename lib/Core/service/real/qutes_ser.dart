import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/config/options.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

Dio dio = Dio();
Future<ResultModel> getPosts() async {
  Response response = await dio.get("${BaseUrl}showAllPosts",
      options: Options(headers: {"Accept": "application/json"}));
  try {
    if (response.statusCode == 200) {
      print("200 in ser getPosts");
      List<PostModel> postslist = List.generate(response.data["data"].length,
          (index) => PostModel.fromMap(response.data["data"][index]));
 //print(getIt<SharedPreferences>().setInt("post ",response.data["data"]["id"].toInt()));
 //getIt<SharedPreferences>().setInt("post_id",response.data["data"]["id"]);
      return ListOf<PostModel>(result: postslist);
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

Future<ResultModel> createPostser(PostModel post) async {
  Response response = await dio.post("${BaseUrl}createPost",
      options: Options(headers: getoptions()), data: post.toMap());
  try {
    if (response.statusCode == 200) {
      print("200 and data has sended");
      return successModel();
    } else {
      print(" ops error in createPost  ");
      return ErrorModel();
    }
  } catch (e) {
    print(" ops exception in createPost  ");
    return ExceptionModel();
  }
}

Future<ResultModel> add_post_tofav_ser(int id) async {
  Response response = await dio.post("$BaseUrl" + "addToFavorite/$id",
      options: Options(headers: getoptions()));
  try {
    if (response.statusCode == 200) {
      print("200 in post to fav service");
      return successModel();
    } else {
      print("err in post to fav service");
      return ErrorModel();
    }
  } catch (e) {
     print("Exception in post to fav service");
    return ExceptionModel();
  }
}
 
 Future<ResultModel>getmyfavpost()async{

  Response response= await dio.get("$BaseUrl"+"showMyFavorite",options: Options(headers: getoptions()));

try{
   
 if (response.statusCode==200) {
 List<ResultModel> list_favqoute=List.generate(response.data["data"].length, (index) =>PostModel.fromMap(response.data["data"][index])
  
 );
   return ListofEverything(listresult: list_favqoute);
 } else {
   return ErrorModel();
 }
}
catch(e){
print(e.toString());
return ExceptionModel();
}

 }