import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/error.dart';
import 'package:userboffee/Core/Models/favourite_model.dart';

abstract class Favourite {
  Dio dio = Dio();
  String baseurl = 'http://localhost:8000/api/favorites';
  late Response response;
  Future<List<FavouriteMODEL>> getAllFavouritebooks();
  Future<FavouriteMODEL> getOnebook();
  createUser(FavouriteMODEL);
  DeletUser(int id);
}

class FavouriteService extends Favourite {
  @override
  DeletUser(int id) {
    // TODO: implement DeletUser
    throw UnimplementedError();
  }

  @override
  createUser(FavouriteMODEL) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<FavouriteMODEL>> getAllFavouritebooks() async {
    try {
      response = await dio.get(baseurl);
      print(response);
      if (response.statusCode == 200) {
        List<FavouriteMODEL> fav_model = List.generate(
            response.data['data'].length,
            (index) => FavouriteMODEL.fromMap(response.data['data'][index]));
        print(response.data);
        return fav_model;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<FavouriteMODEL> getOnebook() {
    // TODO: implement getOnebook
    throw UnimplementedError();
  }
}
