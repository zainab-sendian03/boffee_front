import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';

part 'addpost_event.dart';
part 'addpost_state.dart';

class AddpostBloc extends Bloc<AddpostEvent, AddpostState> {
  AddpostBloc() : super(AddpostInitial()) {
    //!Edit
    // List<PostModel>list_of_new_posts=[];
    on<createpostEvent>((event, emit) async{
    
      var result= await createPostser(event.post);
      try{
        //!Edit
          // list_of_new_posts.add(PostModel(body: "body", user_name: "user_name"));
        if (result is successModel ) {
          
           emit (Succuess_createpostState(
        //    Postlistcreated:list_of_new_posts 
            ));
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
