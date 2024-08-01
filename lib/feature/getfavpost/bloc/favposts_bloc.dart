import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';

part 'favposts_event.dart';
part 'favposts_state.dart';

class FavpostsBloc extends Bloc<FavpostsEvent, FavpostsState> {
  FavpostsBloc() : super(FavpostsInitial()) {
    on<FavpostsEvent>((event, emit) async {
      // TODO: implement event handler

      ResultModel res = await getmyfavpost();
print(res.runtimeType);
      emit(LoadingGetFavpostState());
      if (res is ListofEverything<PostModel>) {
        emit(SuccesGetFavpostState(res.listresult ));
        print("Success in bloc get fav");
      } else if (res is ExceptionModel) {
        print("ExceptionModel in bloc get fav");
        emit(ExceptionGetFavpostState());
      } else {
        emit(ErrorGetFavpostState());
        print("Error in bloc get fav");
      }
    });
  }
}
