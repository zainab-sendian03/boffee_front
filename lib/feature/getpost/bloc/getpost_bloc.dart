import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:userboffee/Core/Models/basic_model.dart';
import 'package:userboffee/Core/Models/post_model.dart';
import 'package:userboffee/Core/service/real/qutes_ser.dart';

part 'getpost_event.dart';
part 'getpost_state.dart';

class GetpostBloc extends Bloc<GetpostEvent, GetpostState> {
  GetpostBloc() : super(GetpostInitial()) {
    on<GettingPostEvent>((event, emit) async{
     dynamic res= await getPosts();
     try{
      if (res is ErrorModel) {
        print("Error in bloc");
        emit(ErorrGetpost_state());
      } 
    
      else {
        print("SuccessGetPost_state");
        emit(SuccessGetPost_state(posts: res ));
      }
     }
     catch(e){ print("ops Exception in GetpostBloc it is ${e.toString()}");
    emit(ExceptionGetpost_state());  
     
     }
    });
  }
}
