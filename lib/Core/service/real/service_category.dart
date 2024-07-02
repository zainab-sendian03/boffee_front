
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/category.dart';
import 'package:userboffee/Core/Models/error.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class categories{
  Dio dio=Dio();
  String baseUrl='${BaseUrl}types';
  late Response response;
  Future<List<ResultModel>> getAllCategories();
  Future<ResultModel> getOnecategory();
  createUser( CategoryModel);
  DeletUser(int id);
}
class serviceUI extends categories{
  @override
  DeletUser(int id) {
    // TODO: implement DeletUser
    throw UnimplementedError();
  }

  @override
  createUser(CategoryModel) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<ResultModel>> getAllCategories() async{
try {
  
  response=await dio.get(baseUrl);
  if (response.statusCode==200){
    List<CategoryModel> category_model =List.generate(response.data['data'].length, (index) => CategoryModel.fromMap(response.data['data'][index]));
    print(response.data);
 return category_model;
  }
  else{return [ErroeModel(message: 'no internet')];}
} catch (e) {
  return[ErroeModel(message: 'no internet')];
}
  }

  @override
  Future<ResultModel> getOnecategory() {
    // TODO: implement getOnecategory
    throw UnimplementedError();
  }
}