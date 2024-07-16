import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_fav_post_event.dart';
part 'add_fav_post_state.dart';

class AddFavPostBloc extends Bloc<AddFavPostEvent, AddFavPostState> {
  AddFavPostBloc() : super(AddFavPostInitial()) {
    on<AddFavPostEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
