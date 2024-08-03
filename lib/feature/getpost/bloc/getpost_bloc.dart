import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';
part 'getpost_event.dart';
part 'getpost_state.dart';

class GetpostBloc extends Bloc<GetpostEvent, GetpostState> {
  GetpostBloc() : super(GetpostInitial()) {
    on<GettingPostEvent>((event, emit) async {
      emit(LoadingToSolveProblem());
      //   print("bloc in  GettingPostEvent");
      ResultModel res = await getPosts();
      // print(" res bloc in  GettingPostEvent ");
      if (res is ErrorModel) {
        // print("Error in bloc GettingPostEvent " );
        emit(ErorrGetpost_state());
      } else if (res is ExceptionModel) {
        //print("Excp in  bloc in GettingPostEvent ");
        emit(ExceptionGetpost_state());
      } else {
        print("SuccessGetPost_state");
        emit(SuccessGetPost_state(posts: (res as ListOf).result));
      }
    });
  }
}
