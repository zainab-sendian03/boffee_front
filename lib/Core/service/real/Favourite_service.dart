import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/favourite_model.dart';
import 'package:userboffee/Core/constants/linksapi.dart';

abstract class Favourite {
  Dio dio = Dio();
  String baseurl = 'http://$ip_Zainab:8000/api/favorites';
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
      print("Response Data: ${response.data}");

      if (response.statusCode == 200 && response.data['data'] != null) {
        List<FavouriteMODEL> fav_model = (response.data['data'] as List)
            .map((item) => FavouriteMODEL.fromMap(item))
            .toList();
        return fav_model;
      } else {
        print("Failed to fetch favorite books");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  @override
  Future<FavouriteMODEL> getOnebook() {
    // TODO: implement getOnebook
    throw UnimplementedError();
  }
}
