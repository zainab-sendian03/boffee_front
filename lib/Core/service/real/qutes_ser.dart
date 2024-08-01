import 'dart:async';

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
   // print(postslist.toString());
  List<dynamic> posts = response.data['data'];

    // Iterate through each post and store the id in shared preferences
    for (int i = 0; i < posts.length; i++) {
      int id = posts[i]['id'];
      // Store the id in shared preferences
      print( "*****${getIt<SharedPreferences>().setInt('post_id',id).toString()}");
      await getIt<SharedPreferences>().setInt('post_id',id);
    }

      
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
  print("enter in createPostser ");
  Response response = await dio.post("${BaseUrl}createPost",
      options: Options(headers: getoptions()), data: post.toMap());
  try {
    print("enter in createPostser ");
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
  print("enter in fav service post");
  print(id);
  Response response =
      await dio.post(BaseUrl+"addToFavorite/${id.toString()}",
          options: Options(
            headers: getoptions(),
            validateStatus: (status) {
              // Define your custom validation logic
              print(status.toString());
              return status != null && status == 200;
            },
          ));
  try {
           //   print(response.data.toString());
    if (response.statusCode == 200) {
       print("####${response.statusMessage}");
      print("200 in post to fav service");
      print("response=${response.data["data"]}");
      return successModel();
    } else {
       print("####${response.statusMessage}");
      print("err in post to fav service");
         print("response=${response.data["data"]}");
    
      return ErrorModel();
    }
  } catch (e) {
      print("####${response.statusMessage}");
    print("Exception in post to fav service");
       print("response=${response.data["data"]}");
    
    return ExceptionModel();
  }
}


Future<ResultModel> remove_post_from_fav(int id) async {
  print("enter in fav service post");
  print(id);
  Response response =
      await dio.delete(BaseUrl+"removeFromFavorites/${id.toString()}",
          options: Options(
            headers: getoptions(),
            validateStatus: (status) {
              // Define your custom validation logic
              print(status.toString());
              return status != null && status == 200;
            },
          ));
  try {
           //   print(response.data.toString());
    if (response.statusCode == 200) {
       print("####${response.statusMessage}");
      print("200 in delet  fav post_ser");
      print("response=${response.data["data"]}");
      return successModel();
    } else {
       print("####${response.statusMessage}");
      print("err  in delet  fav post_ser");
         print("response=${response.data["data"]}");
    
      return ErrorModel();
    }
  } catch (e) {
      print("####${response.statusMessage}");
    print("Exception  in delet  fav post_ser");
       print("response=${response.data["data"]}");
    
    return ExceptionModel();
  }
}





Future<ResultModel> getmyfavpost() async {

  Response response = await dio.get("$BaseUrl"+"showMyFavorite",
      options: Options(headers: getoptions()));
print(response);
  try {
    if (response.statusCode == 200) {
      print(response.statusCode.toString());
      List<PostModel> list_favqoute = List.generate(
          response.data["data"].length,
          (index) => PostModel.fromMap(response.data["data"][index]));
          print(list_favqoute);
      return ListofEverything(listresult: list_favqoute  );
    } else {
      return ErrorModel();
    }
  } catch (e) {
    print(e.toString());
    return ExceptionModel();
  }
}

getLikes_count(int id) async {
  Response response = await dio.get("$BaseUrl+likesCount/$id");
  try {
    if (response.statusCode == 200) {
      return response.data["data"];
    } else {
      return ErrorModel();
    }
  } catch (e) {
    return ExceptionModel();
  }
}


Future<ResultModel> my_post_ser() async {
  Dio dio = Dio();
  Response response = await dio.get(BaseUrl+"showMyPosts",options: Options(headers: getoptions()));
  try {

    if (response.statusCode == 200) {
      print(response.statusCode);
      List<PostModel> mypost_List = List.generate(
          response.data["data"].length,
          (index) => PostModel.fromMap(response.data["data"][index]));
          print(mypost_List.toString());
      return ListofEverything(listresult: mypost_List);
    } else {
      print("error in ser my posts");
      return ErrorModel();
    }
  } catch (e) {
    print("Exception in ser my posts");
    return ExceptionModel();
  }
}