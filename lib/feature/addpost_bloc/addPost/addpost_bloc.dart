import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddpostState> {
  AddpostBloc() : super(AddpostInitial()) {
    on<createpostEvent>((event, emit) async{
      var result= await createPostser(event.post);
      try{
        if (result is successModel ) {
            emit (Succuess_createpostState());
        } else {
          print(" opsss error_createpostState in Bloc");
          emit(Error_createpostState());
        }
      }
      catch(e){
         print(" opsss Excep in Bloc");
         print(e.toString());
          emit(Exception_createpostState());
      }
    
      
    });
  }
}
