import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/levels/image_level.dart';
import 'package:userboffee/Core/service/real/levels.dart';

part 'levels_event.dart';
part 'levels_state.dart';

class LevelsBloc extends Bloc<LevelsEvent, LevelsState> {
  LevelsBloc() : super(LevelsInitial()) {
    on<LevelsEvent>((event, emit) async {
      emit(loading_level_state());
      ResultModel res = await getLevel();
      if (res is ImageLevelModel) {
        print( "if in level bloc");
        emit(Suceess_level_state(image: res.image, ratio:res.ratio ));
        print(Suceess_level_state(image: res.image, ratio:res.ratio ).toString());
      } else if (res is ExceptionModel) {
        emit(Exception_level_state());
      } else {
        emit(Error_level_state());
      }
    });
  }
}
