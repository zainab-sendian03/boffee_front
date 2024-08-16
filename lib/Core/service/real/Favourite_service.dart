import 'package:dio/dio.dart';
import 'package:userboffee/Core/Models/favourite_model.dart';
import 'package:userboffee/Core/config/options.dart';
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
      response =
          await dio.get(baseurl, options: Options(headers: getoptions2()));
      print(response);
      if (response.statusCode == 200) {
        List<FavouriteMODEL> fav_model = List.generate(
            response.data['data'].length,
            (index) => FavouriteMODEL.fromMap(response.data['data'][index]));
        print("sdfg" + response.data);
        return fav_model;
      } else {
        print("fail---");
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
